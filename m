From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sun, 19 Oct 2014 15:57:06 +0000
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>,
 <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
Message-ID: <30e1a5024949427cb08f5c1c8b4ac87f@BY2FFO11FD031.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, for top-posting, but I currently just have Outlook webmail.
The cause for this issue is relatively easily identified. The ethernet drivers sets the Ethernet clock according to the negotioated link speed. For this adjustment a 6-bit divider in the clock path is used. In this case, it seems, the input to the 6-bit divider doesn't allow generating the full range of required frequencies for all supported link speeds.

I guess this could be solved in multiple ways.
1. Disable 1G mode/auto negotiation, the other modes are probably fine (yeah, not a solution, but might give you a working ethernet link)
2. Ensure the divider input allows to generate all required frequencies. This essentially means to go back into Xilinx tools and play around with the clock/PLL setup and re-generating a bootloader that sets things up with the updated values.
3. Support to run-time-adust the PLLs in Zynq. This is definitely the most complex one. I never seriously pursued this, since it seemed close to impossible to change the PLLs at run-time without crashing pretty much every downstream user except for the one that requested the frequency change. And even if every driver would be able to handle such a change, I could imagine that frequency constraints from  all the drivers together would still prevent any change.

        Thanks,
        S?ren

________________________________________
From: devicetree-owner@vger.kernel.org [devicetree-owner at vger.kernel.org] on behalf of Olof Johansson [olof at lixom.net]
Sent: Friday, October 17, 2014 9:28 PM
To: Andreas F?rber
Cc: Michal Simek; Andreas Olofsson; Matteo Vit; Sean Rickerd; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Punnaiah Choudary Kalluri; Lars-Peter Clausen
Subject: Re: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella

Hi Andreas,

On Thu, Jul 24, 2014 at 4:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hello,
>
> This patch series adds an initial device tree for the Parallella board.
> UART, SD card, Ethernet are enabled.
> Not yet enabled are HDMI, QSPI flash and 2x USB.

Andreas (Olofsson) kindly sent me a board, and I added it to the boot
farm today, it'll be included in boot reports from here on.

I did a test run with yesterday's -next It looks like networking isn't
working there at the moment, clock related. Same happens with 3.17 and
latest mainline, config multi_v7_defconfig:

[WARN] [    7.943648] macb e000b000.ethernet eth0: unable to generate
target frequency: 125000000 Hz
[WARN] [   10.948681] macb e000b000.ethernet eth0: unable to generate
target frequency: 125000000 Hz

Full boot log at:

http://arm-soc.lixom.net/bootlogs/misc/next-20141017/parallella-arm-multi_v7_defconfig.html

I'll be happy to try things, but I'm a bit short on cycles to debug
myself. Should hopefully be easy to reproduce.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
