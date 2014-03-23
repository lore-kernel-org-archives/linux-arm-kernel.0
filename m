From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 23 Mar 2014 20:49:41 +0100
Subject: [PATCH 0/8] Generic serial earlycon
In-Reply-To: <CAL_Jsq+j4ixVbfue62q_tOHb-HPA2jAxwZtTjtLy6jE9crGvsg@mail.gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <201403222301.30222.arnd@arndb.de>
 <CAL_Jsq+j4ixVbfue62q_tOHb-HPA2jAxwZtTjtLy6jE9crGvsg@mail.gmail.com>
Message-ID: <201403232049.41866.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 23 March 2014, Rob Herring wrote:
> IIRC, the unflattening cannot be done before memblock is up which is
> in arm_memblock_init. I believe that will get done earlier similar to
> PPC with Laura's meminfo removal series. However, in interest of
> getting output enabled as early as possible, the earliest point is
> always going to be with a flat tree. So I think we do want to be able
> to parse the flat tree for this. There's code in u-boot to do the
> address translation on FDT we can steal. Really, i'd like to put that
> code in libfdt, but there's a licensing problem with the u-boot code
> being GPL and libfdt being BSD.

I suppose it depends on what the goal is. If you are trying to get as
close as possible to the debug_ll functionality without losing the
ability to turn it on unconditionally, I agree that it needs to be done
on the flat tree.

However, the goal that interests me more at the moment is to have
reliable debug output done in a simple way earlier than what we have
today with the normal console support. For this, it seems a better
tradeoff to initialize the early console slightly later. This
can actually be done independent of the the command line option,
I don't see any downsides from having a compile-time option that
would initialize the early console from setup_arch (after
unflatten_device_tree) whenever there is a linux,stdout-path
property that points to a usable device.

	Arnd
