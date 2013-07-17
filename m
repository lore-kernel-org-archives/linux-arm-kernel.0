From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 16 Jul 2013 23:26:49 -0400 (EDT)
Subject: [RFC PATCH v5 0/1] drivers: mfd: Versatile Express SPC support
In-Reply-To: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1373990743-23106-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <alpine.LFD.2.03.1307162323530.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Jul 2013, Lorenzo Pieralisi wrote:

> Hello,
> 
> version v5 of VExpress SPC driver, please read on the changelog for major
> changes and explanations.
> 
> The probing scheme is unchanged, since after trying the early platform
> devices approach it appeared that the end result was no better than the
> current one. The only clean solution relies either on changing how
> secondaries are brought up in the kernel (later than now) or enable
> early platform device registration through DT. Please check this
> thread for the related discussion:
> 
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/036542.html
> 
> The interface was adapted to regmap and again reverted to old driver for
> the following reasons:
> 
> - Power down registers locking is hairy and requires arch spinlocks in
>   the MCPM back end to work properly, normal spinlocks cannot be used
> - Regmap adds unnecessary code to manage SPC since it is just a bunch of
>   registers used to control power management flags, the overhead is just
>   not worth it (talking about power down registers, not the vexpress config
>   interface)
> - The locking scheme behind regmap requires all registers in the map
>   to be protected with the same lock, which is not exactly what we want
>   here
> - Given the reasons above, adding a regmap interface buys us nothing from
>   a driver readability and maintainability perspective (again just talking
>   about the power interface, a few registers) because for the SPC it would
>   simply not be used
> 
> /drivers/mfd is probably not the right place for this code as it stands (but
> probably will be when the entire driver, with DVFS and config interface, is
> complete).
> 
> Thank you for the review in advance,
> Lorenzo

I've integrated this patch in my MCPM backend for TC2 patch series.

ACKs from concerned/interested people would be appreciated so I could 
send this for ARM-SOC inclusion right away.


Nicolas
