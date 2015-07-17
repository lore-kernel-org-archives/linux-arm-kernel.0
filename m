From: const@makelinux.com (Constantine Shulyupin)
Date: Fri, 17 Jul 2015 22:10:00 +0300
Subject: Linux on Armada 370
In-Reply-To: <2423243.x5Zj3FZyBc@wuerfel>
References: <CAE7jHC_u0kTcaRUypSMdL=GqKrizcE8cjbJnp3RJrt9oL8m7ug@mail.gmail.com>
 <20150716171448.59eb45e5@free-electrons.com>
 <2423243.x5Zj3FZyBc@wuerfel>
Message-ID: <CAE7jHC8ogMggTnz=ujVptXLKvA7MMr6hfeROv+gRcGqfJ-VM2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 3:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 July 2015 17:14:48 Thomas Petazzoni wrote:
>>
>> On Thu, 16 Jul 2015 01:24:59 +0300, Constantine Shulyupin wrote:
>>
>> > I want to run the mainstream Linux on Armada 370 and then contribute to it.
>> >
>> > I use custom board derived from DB-88F6710-BP
>> > Now I successfully run Marvell's linux-3.2.54-2014_T1.1 with u-boot
>> > "Marvell version: v2011.12 2013_Q1.0p2"
>> > U-boot and Linux are patched by our OEM according HW changes.
>> >
>> > I unsuccessfully tried to to run linux-4.2 with armada-370-db.dts.
>> >
>> > Can you please tell me, were can I find the latest Linux, which runs
>> > on Armada 370?
>> > What is proper configuration etc?
>>
>> Most likely you're hitting the internal register issue. Can you
>> make sure you have either an A0 or B0 stepping or the 370 (it's shown
>> in the U-Boot messages at boot), and then check whether your internal
>> registers are at 0xd0000000 or 0xf1000000. To achieve this, please run:
>>
>>         md 0xd0020080
>>         md 0xf1020080
>>
>> One of the two may crash the system. If the first command returns
>> 0xd0000000, then your internal registers are at that location. If the
>> second command returns 0xf1000000, then your internal registers are at
>> that location.
>>
>> I suspect that you might be using an old U-Boot that still maps
>> registers at 0xd0000000. You have two choices:
>>
>>  1/ Update your U-Boot. This is the best option obviously. An updated
>>     U-Boot is available for the Armada 370 DB.
>
> That is only really an option if the machine hasn't been deployed
> in the field yet. If it has, then the setting needs to stay
> unmodified, or there is no proper upgrade path because the new
> boot loader breaks the existing 3.2 kernel.
>
>>  2/ Change the kernel armada-370-db.dts to use the internal registers
>>     at 0xd0000000. Basically, you can revert commit
>>     4f054d445139d63868f931328f897ac5ef87242e.
>
> Right, and if that works, we can add a new dts file for that machine
> with the correct setting. I would assume that there are a few other
> changes compared to DB-88F6710-BP, so the new file should enable
> exactly those devices that are in fact wired up on Constantine's board.
>
>         Arnd

Thank you.
I changed internal register to 0xd0000000 and it boots till network
configuration and powers off by it self.
The last log I see is:

NET: Registered protocol family 17
Key type dns_resolver registered
ThumbEE CPU extension supported.
Registering SWP/SWPB emulation handler
hctosys: unable to open rtc device (rtc0)
mvneta d0070000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
IP-Config: Guessing netmask 255.255.0.0
IP-Config: Complete:
     device=eth0, hwaddr=36:17:d5:87:ee:6e, ipaddr=169.254.0.2,
mask=255.255.0.0, gw=255.255.255.255
     host=169.254.0.2, domain=, nis-domain=(none)
     bootserver=255.255.255.255, rootserver=169.254.0.1, rootpath=


Tested on 4.2.0-rc1-00088-gb9243b5 and 4.0.0-rc1-00002-g4f054d4

What can you suggest?

Thanks constantine
