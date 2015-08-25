From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 09:15:56 +0100
Subject: Prevent list poison values from being mapped by userspace
 processes
In-Reply-To: <55DB16AF.7090607@freebox.fr>
References: <CABXk95C=CpeL4mNmS6-jJ-0bMJf6fawwfs6DM1-p8FctTEFbpw@mail.gmail.com>
 <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <55DB16AF.7090607@freebox.fr>
Message-ID: <20150825081556.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 03:05:51PM +0200, Nicolas Schichan wrote:
> I gave your patch serie a try on ARMv5/kirkwood (backported on a v4.1 kernel)
> and at first I got the following panic just after the kernel transitioned
> to userland (with CONFIG_CPU_SW_DOMAIN_PAN=y):

Ah, damn.  Thanks for testing.  I really need to add some non-ARMv7
platforms to my nightly test rig, but I'm out of physical space to
do that. :p

> I have tracked this to the attempt made by the code in
> arch/arm/mm/abort-ev5t.S to read the fault instruction which in this
> case is in unserspace:
> 
> 	ldreq	r3, [r4]			@ read aborted ARM instruction

There's going to be many more of these... it may be better if I left
the domain enabled when calling into these handlers, and had every
handler do the turn-off itself when it's ready to do so - there's
no point turning off userspace access only to then immediately
re-enable it.

> With the changes above, userland boots fine and attempts to
> dereference LIST_POISON1 from the kernel results the expected "page
> domain fault".
> 
> To test that I mapped LIST_POISON1 from user space via mmap() and
> triggered the fault by reading from /proc/cpu/alignment. I modified the
> code showing /proc/cpu/alignment to access LIST_POISON1. Without your
> patch serie the access to LIST_POISON1 goes through without a hitch.

Great, thanks for the independent testing of its effectiveness.

> Also, when CONFIG_CPU_SW_DOMAIN_PAN is not set, the DACR_INIT constant is
> setup with (domain_val(DOMAIN_USER, DOMAIN_NOACCESS) which will cause the
> kernel to die with a "page domain fault" when running init.

If you don't mind, I'll merge that into the patch adding this so it
doesn't introduce a regression there.

Once I've fixed the abort handler issue, would you mind re-testing
and giving a tested-by attributation please?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
