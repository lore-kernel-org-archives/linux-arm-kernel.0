From: Vincent.Yang@tw.fujitsu.com (Vincent.Yang)
Date: Sun, 13 Jul 2014 17:44:04 +0800
Subject: [PATCH 1/4] mmc: sdhci: add quirk for voltage switch callback
In-Reply-To: <20140713082136.GJ21766@n2100.arm.linux.org.uk>
References: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1405228870-5088-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20140713082136.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <830AC58E49A426478AC39824BC0FA915D8B8F21DDB@fmpitwmsex01.fmpi.sea.css.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>On Sun, Jul 13, 2014 at 01:21:07PM +0800, Vincent Yang wrote:
>> @@ -1763,6 +1763,11 @@ static int sdhci_do_start_signal_voltage_switch(struct
>sdhci_host *host,
>>               ctrl |= SDHCI_CTRL_VDD_180;
>>               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> +             /* Some controller need to do more when switching */
>> +             if ((host->quirks2 & SDHCI_QUIRK2_VOLTAGE_SWITCH) &&
>> +                 host->ops->voltage_switch)
>> +                     host->ops->voltage_switch(host);
>> +
>
>Why do you heed SDHCI_QUIRK2_VOLTAGE_SWITCH?  Isn't populating
>ops->voltage_switch enough? to indicate that something needs to be
>done?

Hi Russell,
I will update it as below and remove SDHCI_QUIRK2_VOLTAGE_SWITCH in
next version.
+               /* Some controller need to do more when switching */
+               if (host->ops->voltage_switch)
+                       host->ops->voltage_switch(host);
+

Thanks a lot for your review!

Best regards,
Vincent Yang

>
>It would also be better to turn sdhci.c into a library, and have
>the platform driver call the appropriate functions in sdhci rather
>than having sdhci be a core driver with loads of quirks.  This is
>what I've done in my previous series where I changed stuff such as
>the set_bus_width(), set_uhs_signaling() and similar callbacks.
>
>So, it probably makes more sense to split
>sdhci_do_start_signal_voltage_switch() into a load of smaller library
>functions which drivers can call in an appropriate sequence, rather
>than having a quirk hook.
>
>The problem with quirk hooks is that what is right for one device
>is not right for another device - eventually you end up with lots
>of quirk callbacks scattered on every alternate line.  That doesn't
>scale.
>
>Experienced kernel programmers know this and this is why words like
>"framework" fill those who have encountered this problem with dread.
>sdhci.c is a prime example of this kind of design mistake.
>
>--
>FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
>according to speedtest.net.
