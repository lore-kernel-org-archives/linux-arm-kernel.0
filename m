From: andy@warmcat.com (Andy Green)
Date: Wed, 24 Mar 2010 09:19:58 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
Message-ID: <4BA9D93E.50705@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/10 07:10, Somebody in the thread at some point said:
> Hello,
>
> I've encountered a problem with regulator framework and the device
> probe order. In my system there is a pmic chip connected thought i2c
> bus and a platform device (let's call it A) that depends on the
> regulator device (for proper probing pmic chip must enable voltage to
> the device A). In the current configuration the i2c driver is also a
> platform device. However during the system initialization the device
> A is probed before the i2c driver would register pmic chip and its
> regulators.
>
> How I can delay probing the device A to the moment when the regulator
> device will be available in the system? Is there any generic was of
> changing the device probe order?

Delaying registering devices is only half the problem.  You must also 
correct these device's parent dev to be the PMU's.

Otherwise your suspend and resume ordering turns to crap and you will 
immediately be in Hell, for example the PMIC may go down taking away 
power from the SD Card before you finished talking to it.

With correct device parent ordering, then children are guaranteed to be 
suspended before the parent, it means the PMIC won't go down until all 
these guys registered as dependent on it have nicely gone down.

What I have been doing is adding a platform callback in the pmic 
platform_data which is called at the end of pmic probe.

In the machine file, in the callback I then register everything that 
relies on PMIC power arrangements, and correct the device parent at to 
be the PMIC at the same time.

It would be very good is this was regularized somehow into a standard 
API because it's absolutely a requirement for many boards that their 
devices ARE dependent on PMU as a parent.

-Andy
