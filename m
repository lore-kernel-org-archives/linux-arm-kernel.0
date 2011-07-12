From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jul 2011 14:52:14 +0200
Subject: [PATCH 16/17] mach-sa1100: retire custom LED code
In-Reply-To: <20110712073037.GA23270@n2100.arm.linux.org.uk>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<CAK5ve-LNDCN0P6L_5-L4PT11n1Tiv0qz=8=rgmv-v7WsEDotBQ@mail.gmail.com>
	<20110712073037.GA23270@n2100.arm.linux.org.uk>
Message-ID: <201107121452.14705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 July 2011, Russell King - ARM Linux wrote:
> On Tue, Jul 12, 2011 at 08:31:28AM +0800, Bryan Wu wrote:
> > I think this is a great idea. what about moving it to include/asm-generic/

I wouldn't want to encourage new architectures to actually use this method
until they grow to need it. For most simple architectures, it's probably
better to have a different method of doing machine specific work.

> Except, instead of:
> 
> 		if (machine_is(mach)) return fn(); \
> 
> we'd need:
> 
> 		if (machine_is_##mach()) return fn(); \

Right. Maybe we can start simple and just do a single definition at fs_initcall level:

#define machine_initcall(mach,level,fn) \
        static int __init __machine_initcall_##mach##_##fn(void) { \
                if (machine_is ## mach()) return fn(); \
                return 0; \
        } \
        fs_initcall(,__machine_initcall_##mach##_##fn);


	Arnd
