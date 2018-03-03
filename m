From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 3 Mar 2018 14:58:45 +0100 (CET)
Subject: [PATCH 1/2] mmc: bcm2835: reset host on timeout
In-Reply-To: <20180214202454.6e7ebeaf@naga.suse.cz>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
 <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
 <20180214202454.6e7ebeaf@naga.suse.cz>
Message-ID: <166274019.307112.1520085525833@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

[add Stefan to CC]

> Michal Such?nek <msuchanek@suse.de> hat am 14. Februar 2018 um 20:24 geschrieben:
> 
> 
> On Wed, 14 Feb 2018 17:49:31 +0100
> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> > Hi Michal,
> > 
> > [add Phil]
> > 
> > Am 14.02.2018 um 17:13 schrieb Michal Such?nek:
> > > On Wed, 14 Feb 2018 16:36:49 +0100
> > > Michal Such?nek <msuchanek@suse.de> wrote:
> > >  
> > >> On Wed, 14 Feb 2018 15:58:31 +0100
> > >> Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > >>  
> > >>> Hi Michal,
> > >>>
> > >>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:    
> > >>>> The bcm2835 mmc host tends to lock up for unknown reason so reset
> > >>>> it on timeout. The upper mmc block layer tries retransimitting
> > >>>> with single blocks which tends to work out after a long wait.
> > >>>>
> > >>>> This is better than giving up and leaving the machine broken for
> > >>>> no obvious reason.      
> > >>> could you please provide more information about this issue
> > >>> (affected hardware, kernel config, version, dmesg, reproducible
> > >>> scenario)? 
> > > It tends to reproduce when upgrading a few packages with zypper and
> > > otherwise at random during system operation. It seems that for my
> > > card it worsens with age to some degree so perhaps it depends on the
> > > fragmentation of the internal card flash.
> > >
> > > Attaching dmesg and kernel config.  
> > 
> > do you noticed this issue before 4.15-rc4?
> 
> I initially noticed it with 4.4 kernel with some backports to make it
> bootable on RPi.
> > 
> > Could you please test with 4.15 final again?
> 
> Right, I can apply the patches on something more recent.
> 
> > 
> > What kind of SD card (name) triggers the issue?
> 
> Samsung EVO MB-MP16D
> 
> Also see https://elinux.org/RPi_SD_cards#Which_SD_card.3F
> 
> Thanks
> 
> Michal
> 

yesterday i finished my stress tests with Raspberry Pi 3.

Scenario:
- copy Tumbleweed on SD card (openSUSE-Tumbleweed-ARM-JeOS-raspberrypi3.aarch64-2018.02.02-Build1.2.raw, Linux 4.14.15)
- setup locales with yast
- run zypper update
- reboot
- install and remove java 1.8 in a loop for at least 1 hour

Results of the different SD cards:
Toshiba uSDHC Class 10 UHS-1 32 GB: PASS
BASETech uSDHC Class 10 16 GB: PASS
Samsung uSDHC EVO+ UHS-1 16 GB: PASS
Samsung uSDHC Class 6 32 GB: PASS
SanDisk Edge Class 4 16 GB: PASS
Kingston uSDHC Class 10 UHS-1 32 GB: PASS
QUMOX uSDHC Class 10 UHS-1 16 GB: FAIL (zypper segfaulted permantently)
Transcend uSDHC Class 10 UHS-1 32 GB: PASS

I was never able to reproduce this timeout. So i still need the feedback about the 4.15 and i a reliable test scenario.

In a github issue, i've read that badblocks could reproduce the issue more likely.

Regards
Stefan
