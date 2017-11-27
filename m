From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Nov 2017 13:55:23 +0000
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171127133631.GE19413@lunn.ch>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
 <08bb4658-5b62-e306-5aa8-366be25986ca@linaro.org>
 <20171127104034.205fc0b50e9bf9dafdcd05c7@kernel.org>
 <20171127133631.GE19413@lunn.ch>
Message-ID: <20171127135523.GE31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 02:36:31PM +0100, Andrew Lunn wrote:
> On Mon, Nov 27, 2017 at 10:40:34AM +0900, Masami Hiramatsu wrote:
> > On Sun, 26 Nov 2017 22:59:58 +0800
> > Alex Shi <alex.shi@linaro.org> wrote:
> > 
> > > cc mhiramat at kernel.org
> > > 
> > > Thanks a lot for look into this! :)
> > > 
> > > Regards
> > > Alex
> > > 
> > > On 11/25/2017 04:25 AM, Russell King - ARM Linux wrote:
> > > > On Fri, Nov 24, 2017 at 07:27:00PM +0000, Russell King - ARM Linux wrote:
> > > >> Adding Tixy, as he's more knowledgable in this area - I suggest
> > > >> someone knowledgable in this area runs
> > > >>
> > > >> 	ftracetest test.d/kprobe/multiple_kprobes.tc
> > > >>
> > > >> and fixes these bugs... also running the entire ftracetest suite
> > > >> would probably also be a very good idea.
> > > > 
> > > > There's some other stupidities as well:
> > > > 
> > > > trace_kprobe: Inserting kprobe at __error_lpae+0
> > > > trace_kprobe: Inserting kprobe at str_lpae+0
> > > > trace_kprobe: Inserting kprobe at __error_p+0
> > > > trace_kprobe: Inserting kprobe at str_p1+0
> > > > trace_kprobe: Inserting kprobe at str_p2+0
> > > > trace_kprobe: Could not insert probe at str_p2+0: -22
> > > > 
> > > > str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
> > > > str_p1: .asciz  "\nError: unrecognized/unsupported processor variant (0x"
> > > > str_p2: .asciz  ").\n"
> > > > 
> > > > So we successfully placed a kprobe on some ASCII strings, which are
> > > > used prior to the kernel being properly up and running, which means
> > > > we have to use relative references to these strings, and relative
> > > > references to strings in other sections is not simple.
> > 
> > Oops, that's my mistake. It should pick only text symbols.
> 
> Hi Masami, Russell
> 
> Does the fact you are allowed to put a kprobe on an ASCII string from
> userspace indicate a real problem? I would of thought the kernel core
> kprobe could would be looking at the type of a symbol and rejecting
> such requests. So fix the core, keep this test and make sure you get
> an EINVAL back?

As far as I'm aware, the kernel doesn't know whether the address that
userspace wants to set a kprobe is code or any kind of data.  All that
it can do is:

1. Translate the address to a ksym and offset, looking it up in
   blacklists/blacklisted sections.
2. Look at the "instruction" and reject if it thinks the instruction
   is unsuitable.

Making the kernel reject placing a kprobe on a local function ("t" in
nm's or /proc/kallsyms output) would severely restrict the usefulness
of kprobes - that would mean you couldn't ever set a kprobe on a static
function.

So no, I don't agree with you.

Normally, there won't be strings in the .text section, but we have some
exceptions in ARM code where we have to have them to make early kernel
entry code sane without having to jump through excessive hoops.

As I've already said, we should not be placing kprobes even on this
code.  Think about a kprobe placed on the secondary CPU entry point,
where the CPU is running with the MMU off and there's no exception
table in place.  The kprobe instruction is a CPU undefined instruction,
so the CPU will try and take the undefined instruction vector, which
won't be present - the result will be an instant crash.

The same is true of the identity-mapped code - which again can run
with the MMU off, and suffer from exactly the same issue.

Then we have the exception code itself.  Consider the implications of
placing the kprobe undefined instruction somewhere in the undefined
instruction exception handling code - that would result in recursive
faulting if placed on the SVC paths.

So no, this problem has nothing to do with symbol types - it's about
what code is safe for kprobes to be placed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
