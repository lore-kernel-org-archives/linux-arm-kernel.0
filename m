From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 27 Jan 2018 14:23:57 -0800
Subject: [PATCH v3 4/6] arm: Add icache invalidation on switch_mm for
 Cortex-A15
In-Reply-To: <20180125152139.32431-5-marc.zyngier@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <20180125152139.32431-5-marc.zyngier@arm.com>
Message-ID: <f3af9f2b-ddc2-f0e2-3c80-6e93f9839861@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2018 07:21 AM, Marc Zyngier wrote:
> In order to avoid aliasing attacks against the branch predictor,
> Cortex-A15 require to invalidate the BTB when switching
> from one user context to another. The only way to do so on this
> CPU is to perform an ICIALLU, having set ACTLR[0] to 1 from secure
> mode.

Even though this is a platform design mistake, let's say your Linux
kernel boots in secure supervisor mode, we could have code
that tries to set ACTLR[0] as early as possible, since the writes are
ignored if executing from non-secure mode. If Linux is booted normally
either PL1 or PL2 non-secure we could still check ACTLR[0].

My concern is that without doing this, we may have a hard time catching
improper firmware as well as having bogus bug reports. This is
completely RFC though since:

- I could not quite figure out yet why update ca15_actlr_status from
assembly is not reflected in the C code despite using PC relative loads

- this is done in __ca15mp_setup and __b15mp_setup because we know by
then that we have either of these two CPUs but we could presumably move
this check under a Kconfig option and earlier where all erratas are checked

-- 
Florian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: actlr-kernel-check.patch
Type: text/x-patch
Size: 4133 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180127/da1e1735/attachment-0001.bin>
