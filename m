From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 11 Oct 2014 18:56:51 +0200
Subject: [RFC] drop owner assignment from platform_drivers
In-Reply-To: <2769473.KEN6DZKnT7@wuerfel>
References: <20141010072439.GA1741@katana>
 <20141010083627.GL5182@n2100.arm.linux.org.uk>
 <20141010182604.GC6075@katana> <2769473.KEN6DZKnT7@wuerfel>
Message-ID: <20141011165650.GA1263@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > You got me wondering, though, that it could not be correct to call
> > platform_driver_register() from the platform core instead of module
> > init. I will check tomorrow. Still, this would be a bug independent of
> > my series. Although I'd need to respin it if platform_driver_probe()
> > needed a fix.
> 
> Right, this seems to be a preexisting bug. platform_create_bundle 
> and platform_driver_probe will both overwrite the .owner field with
> NULL since they live in builtin code. They need to be replaced with
> __platform_driver_probe and __platform_driver_register that both
> take an extra owner argument passed down from the caller in the driver
> module.

Yeah, that would be one solution. However, my personal favourite would
meanwhile be to revert the commit that Russell mentioned. I think it is
cleaner to have the owner explicitly set in the module rather than
hidden away by a function call. However, grepping through include/linux,
there are a few subsystems hiding it this way. So, it is a pattern
somewhow. Oh well...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141011/5e94dd0f/attachment.sig>
