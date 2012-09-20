From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Thu, 20 Sep 2012 21:29:15 +0200
Subject: pxa:spitz_pm.c: commit b6eede11 breaks spitz resume under certain
 conditions.
Message-ID: <CAHod+GeMyc+5ERmzY4CYp3SJK-6LOQrhLrLiXSuV3Pdr8+UzSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

========================================================
commit b6eede112673678f8a7a1680d6ad12245443829d
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Mon Jan 11 16:17:25 2010 +0800

    [ARM] pxa/spitz: use generic GPIO API and remove pxa_gpio_mode()

    REVISIT: change to GPIO18 is ugly, need to make sure whether that's
    really necessary - GPIO18_RDY as an VLIO input signal - we don't
    normally need to do such kind of trick during low power mode.

=========================================================

This GPIO18 change breaks spitz resume.
Spitz will fail to resume from STR under these conditions:

1) If the AC plug is powered and plugged in, and if you suspend the machine,
    the machine will not be able to resume if you remove the AC plug while the
   device is suspended.

2) If you connect the machine to a powered AC plug while the device is
suspended,
    the machine will not be able to resume.

If i comment out the call to pxa2xx_mfp_config in spitz_postsuspend(),
my machine will
properly resume under abovementioned conditions.

If i understand correctly, spitz_postsuspend () configures GPIO 18
to alternate mode 1 - RDY. However, I have no idea what RDY means or
what this GPIO is used for.

Eric can you please explain what's happening here?
