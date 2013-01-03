From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 3 Jan 2013 11:08:52 -0700
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <20130103122100.GN2631@n2100.arm.linux.org.uk>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
 <50E4C9C6.20609@codeaurora.org>
 <20130103120259.GB5193@mudshark.cambridge.arm.com>
 <20130103122100.GN2631@n2100.arm.linux.org.uk>
Message-ID: <20130103180852.GA7114@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 12:21:00PM +0000, Russell King - ARM Linux wrote:

> This means we could have KEXEC select PM_SLEEP_SMP (and maybe PM_SLEEP) as
> required, rather than bringing in the entire suspend support just to have
> working kexec.
> 
> However, how many platforms don't have suspend support enabled?

I was looking into something similar to this for Kirkwood - my
interest was in getting kexec to work, which means it needs to call
the hibernation callbacks in the drivers prior to execing, otherwise
there is a fairly high chance DMA will corrupt the kexec target.

So this means the code needs the suspend support, however Kirkwood
doesn't have any support for ARM_CPU_SUSPEND, which blocks enabling
suspend at all for that platform. I was looking at moving the 'depends
on CPU_..' from ARCH_SUSPEND_POSSIBLE to ARM_CPU_SUSPEND, which seemed
to do the trick for kirkwood but I didn't study every possibility..

Regards,
Jason
