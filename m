From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Nov 2017 14:36:31 +0100
Subject: do page fault in atomic bug on arm
In-Reply-To: <20171127104034.205fc0b50e9bf9dafdcd05c7@kernel.org>
References: <d83cdbf1-0d27-fb82-14c8-3d37101c3c06@linaro.org>
 <20171121132001.GH31757@n2100.armlinux.org.uk>
 <64cbcda0-d040-4872-4a6b-7cd18375b4aa@linaro.org>
 <20171124192700.GU31757@n2100.armlinux.org.uk>
 <20171124202553.GV31757@n2100.armlinux.org.uk>
 <08bb4658-5b62-e306-5aa8-366be25986ca@linaro.org>
 <20171127104034.205fc0b50e9bf9dafdcd05c7@kernel.org>
Message-ID: <20171127133631.GE19413@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 10:40:34AM +0900, Masami Hiramatsu wrote:
> On Sun, 26 Nov 2017 22:59:58 +0800
> Alex Shi <alex.shi@linaro.org> wrote:
> 
> > cc mhiramat at kernel.org
> > 
> > Thanks a lot for look into this! :)
> > 
> > Regards
> > Alex
> > 
> > On 11/25/2017 04:25 AM, Russell King - ARM Linux wrote:
> > > On Fri, Nov 24, 2017 at 07:27:00PM +0000, Russell King - ARM Linux wrote:
> > >> Adding Tixy, as he's more knowledgable in this area - I suggest
> > >> someone knowledgable in this area runs
> > >>
> > >> 	ftracetest test.d/kprobe/multiple_kprobes.tc
> > >>
> > >> and fixes these bugs... also running the entire ftracetest suite
> > >> would probably also be a very good idea.
> > > 
> > > There's some other stupidities as well:
> > > 
> > > trace_kprobe: Inserting kprobe at __error_lpae+0
> > > trace_kprobe: Inserting kprobe at str_lpae+0
> > > trace_kprobe: Inserting kprobe at __error_p+0
> > > trace_kprobe: Inserting kprobe at str_p1+0
> > > trace_kprobe: Inserting kprobe at str_p2+0
> > > trace_kprobe: Could not insert probe at str_p2+0: -22
> > > 
> > > str_lpae: .asciz "\nError: Kernel with LPAE support, but CPU does not support LPAE.\n"
> > > str_p1: .asciz  "\nError: unrecognized/unsupported processor variant (0x"
> > > str_p2: .asciz  ").\n"
> > > 
> > > So we successfully placed a kprobe on some ASCII strings, which are
> > > used prior to the kernel being properly up and running, which means
> > > we have to use relative references to these strings, and relative
> > > references to strings in other sections is not simple.
> 
> Oops, that's my mistake. It should pick only text symbols.

Hi Masami, Russell

Does the fact you are allowed to put a kprobe on an ASCII string from
userspace indicate a real problem? I would of thought the kernel core
kprobe could would be looking at the type of a symbol and rejecting
such requests. So fix the core, keep this test and make sure you get
an EINVAL back?

   Andrew
