From: alchark@gmail.com (Alexey Charkov)
Date: Fri, 12 Nov 2010 23:14:12 +0300
Subject: [PATCH 1/6 v6] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <20101112165420.GA6928@alchark-u3s.lan>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<20101107165745.GB1759@n2100.arm.linux.org.uk>
	<AANLkTimFJ=Brx4pDiUqZOKDfABaDg0s_yFC7EkZGi7D8@mail.gmail.com>
	<20101107171726.GF1759@n2100.arm.linux.org.uk>
	<20101108171930.GA1471@alchark-u3s.lan>
	<20101111212322.GA15533@alchark-u3s.lan>
	<20101111234957.GA28735@n2100.arm.linux.org.uk>
	<20101112165420.GA6928@alchark-u3s.lan>
Message-ID: <AANLkTimvMz6EJcCPjhVq5u8x3BWjCCgspbjfa0DQXJr-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Russell, could you please elaborate on your comment regarding spinlocks
> and irq handlers? I always compile my kernel with all kinds of lock
> debugging, and have not run into any associated warnings. Is there
> anything suspicious specifically?

My fault: actually, those were not all lock debugging functions. It
really prints errors when lock correctness proving is enabled. I thus
decided to just assign the callback functions directly to irq_desc
struct fields, as it is done in mach-msm.

There is, however, another error showing up: it complains about my use
of ioremap inside arch_reset(). Is it fine to just hardcode the
virtual address of the respective register and use that directly in
this case? Something along the lines of:

/* PM Software Reset request register */
#define VT8500_PMSR_VIRT	0xf8130060

static inline void arch_reset(char mode, const char *cmd)
{
	writel(1, VT8500_PMSR_VIRT);
}

Thanks,
Alexey
