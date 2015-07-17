From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jul 2015 14:30:36 +0200
Subject: Linux on Armada 370
In-Reply-To: <20150716171448.59eb45e5@free-electrons.com>
References: <CAE7jHC_u0kTcaRUypSMdL=GqKrizcE8cjbJnp3RJrt9oL8m7ug@mail.gmail.com>
 <20150716171448.59eb45e5@free-electrons.com>
Message-ID: <2423243.x5Zj3FZyBc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 July 2015 17:14:48 Thomas Petazzoni wrote:
> 
> On Thu, 16 Jul 2015 01:24:59 +0300, Constantine Shulyupin wrote:
> 
> > I want to run the mainstream Linux on Armada 370 and then contribute to it.
> > 
> > I use custom board derived from DB-88F6710-BP
> > Now I successfully run Marvell's linux-3.2.54-2014_T1.1 with u-boot
> > "Marvell version: v2011.12 2013_Q1.0p2"
> > U-boot and Linux are patched by our OEM according HW changes.
> > 
> > I unsuccessfully tried to to run linux-4.2 with armada-370-db.dts.
> > 
> > Can you please tell me, were can I find the latest Linux, which runs
> > on Armada 370?
> > What is proper configuration etc?
> 
> Most likely you're hitting the internal register issue. Can you
> make sure you have either an A0 or B0 stepping or the 370 (it's shown
> in the U-Boot messages at boot), and then check whether your internal
> registers are at 0xd0000000 or 0xf1000000. To achieve this, please run:
> 
>         md 0xd0020080
>         md 0xf1020080
> 
> One of the two may crash the system. If the first command returns
> 0xd0000000, then your internal registers are at that location. If the
> second command returns 0xf1000000, then your internal registers are at
> that location.
> 
> I suspect that you might be using an old U-Boot that still maps
> registers at 0xd0000000. You have two choices:
> 
>  1/ Update your U-Boot. This is the best option obviously. An updated
>     U-Boot is available for the Armada 370 DB.

That is only really an option if the machine hasn't been deployed
in the field yet. If it has, then the setting needs to stay
unmodified, or there is no proper upgrade path because the new
boot loader breaks the existing 3.2 kernel.

>  2/ Change the kernel armada-370-db.dts to use the internal registers
>     at 0xd0000000. Basically, you can revert commit
>     4f054d445139d63868f931328f897ac5ef87242e.

Right, and if that works, we can add a new dts file for that machine
with the correct setting. I would assume that there are a few other
changes compared to DB-88F6710-BP, so the new file should enable
exactly those devices that are in fact wired up on Constantine's board.

	Arnd
