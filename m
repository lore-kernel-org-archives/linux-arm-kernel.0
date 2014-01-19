From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 20:07:46 +0100
Subject: [RFC v3 09/13] ARM: sunxi: Add support for Allwinner SUNXi SoCs
 sata to ahci_platform
In-Reply-To: <20140119122216.GM15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-10-git-send-email-hdegoede@redhat.com>
 <20140119122216.GM15937@n2100.arm.linux.org.uk>
Message-ID: <52DC2282.4040702@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 01:22 PM, Russell King - ARM Linux wrote:
> On Sun, Jan 19, 2014 at 12:48:51AM +0100, Hans de Goede wrote:
>> +	timeout = 0x100000;
>> +	do {
>> +		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
>> +	} while (--timeout && (reg_val != 0x2));
>> +	if (!timeout) {
>> +		dev_err(dev, "PHY power up failed.\n");
>> +		return -EIO;
>> +	}
>
> This is not a good way to detect failure - there's several things wrong
> here.
>
> First, how long does sunxi_getbits() take?  What does that depend on?
> Therefore, how long does it take to time out?

You're interpreting the timeout in the above code as an actual timeout, but
that is not what it is, it is a means to avoid looping forever if something
is seriously amiss. The only time I've ever seen the timeout trigger is when
I forgot to enable some clks iirc.

I can rename the variable from timeout to max_tries to make this more clear.

> Secondly, what if the success condition becomes true at the same time that
> a timeout occurs?

We should never get anywhere near timeout becoming 0, so if both happen at
the same time, then something is pretty seriously broken and the returning of
an error as the code does now is the right thing to do.

Regards,

Hans
