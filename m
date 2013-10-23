From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 23 Oct 2013 11:06:18 +0200
Subject: userspace firmware load fails with current linux-next
Message-ID: <20131023110618.7bd07899@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

with the current linux-next loading firmware from userspace fails
because when writing to /sys/class/firmware/*/data the return code is
always 0 (meaning to the userspace too that no data was written).
Thus the userspace tool (mdev) keeps writing the same block of data
over and over again.

A cursory check of the latest updates to /drivers/base/firmware* didn't
reveal anything that could be the cause of this misbehaviour.

Interestingly when changing the .size member of the
struct bin_attribute firmware_attr_data in drivers/base/firmware_class.c
(which is now '0') to e.g. PAGE_SIZE firmware loading works again.

Since .size was at '0' since the beginning of the .git universe there
must have been a fundamental change in the guts of the kernel handling
sysfs attribute files.

Is this behavioural change intended?
Do all sysfs attributes that are created with zero size need to be
changed?
Or is it an unintended side effect of some recent change?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
