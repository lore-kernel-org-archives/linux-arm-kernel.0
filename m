From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jan 2015 16:35:05 +0000
Subject: [PATCH v20 08/11] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1420799154.4160.19.camel@linaro.org>
References: <1420457376-77366-1-git-send-email-wangnan0@huawei.com>
 <1420785456-21900-1-git-send-email-wangnan0@huawei.com>
 <1420799154.4160.19.camel@linaro.org>
Message-ID: <20150109163505.GS12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 10:25:54AM +0000, Jon Medhurst (Tixy) wrote:
> On Fri, 2015-01-09 at 14:37 +0800, Wang Nan wrote:
> > +			"	and	r4, sp, #4\n"
> > +			"	sub	sp, sp, r4\n"
> > +#if __LINUX_ARM_ARCH__ >= 5
> > +			"	blx	r2\n"
> > +#else
> > +			"	mov     lr, pc\n"
> > +			"	bx	r2\n"
> 
> I think the BX instruction is not supported for ARMv4 chips that don't
> have Thumb support (e.g. SA110), at least an old ARM ARM I have says BX
> is supported on "Version 5 and above, and T variants of version 4".

Correct.

> Though building assabet_defconfig with kprobes enabled doesn't produce
> an error for the BX instruction (!?)

Which config are you using?  Does it have CONFIG_CPU_32v4 enabled?
That should result in "-D__LINUX_ARM_ARCH__=4 -march=armv4" being
passed to the compiler (please check with make V=1).

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
