From: dianders@chromium.org (Doug Anderson)
Date: Wed, 16 Sep 2015 15:02:52 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <55F9DC10.9020508@mentor.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=U2BR=Qk2cVS-cq78Rx=VjriZiE6nC3cn+_SBHx2_5ihg@mail.gmail.com>
 <20150902230408.GR21084@n2100.arm.linux.org.uk>
 <CAD=FV=XO0cjmmXniGnqvvoWZ=e1EL7t5XDUXVhiNMqWvmaOpMw@mail.gmail.com>
 <55F9DC10.9020508@mentor.com>
Message-ID: <CAD=FV=UOZ3v_MPYMP8BJM+RnAndoj4K2B6n_mgnci5Ja4jpoAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 16, 2015 at 2:16 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> Hi Doug,
>
> On 03.09.2015 02:19, Doug Anderson wrote:
>> Russell,
>>
>> On Wed, Sep 2, 2015 at 4:04 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>>>> Also, is it appropriate to hook non-DDC devices to a DDC bus?  I suspect
>>>>> that's asking for trouble.
>>>>
>>>> I doubt it's appropriate.  Why do you ask?
>>>
>>> To find out why you want to "specify the I2C bus".
>>>
>>> Surely if we're talking about the DDC bus, we either want to use a
>>> separate I2C bus (in which case the HDMI DT description needs to
>>> specify which I2C bus to use) or we want to use the HDMI-internal
>>> I2C bus, which being part of the HDMI driver, the HDMI driver will
>>> know how to find it itself - there should be no need to put an
>>> explicit ddc-i2c-bus self-reference there in that case.
>>
>> Overall it comes down to bus numbering.  Possibly that's a stupid
>> reason, but it is my reason nevertheless.
>
> this is a known issue regarding I2C bus numbering.
>
>> Specifically it significantly helps my brain process kernel log
>> messages if the i2c bus that's referred to "bus 5" in my SoC's user
>> manual shows up consistently as "i2c5" in kernel log messages.  It's
>> helpful it it shows up as "i2c5" even if "i2c0" - "i2c4" aren't
>> enabled.
>>
>> That's all totally possible by using this type of syntax, like in rk3288.dtsi:
>>
>> aliases {
>>   i2c0 = &i2c0;
>>   i2c1 = &i2c1;
>>   i2c2 = &i2c2;
>>   i2c3 = &i2c3;
>>   i2c4 = &i2c4;
>>   i2c5 = &i2c5;
>>
>> Similarly, I'd like "bus 0" to show up as i2c0, which will happen as
>> you can see in the above.
>>
>> The problem is that if another bus registers itself before the SoC's
>> i2c0 registers itself and that bus doesn't give a number to itself
>> then the i2c subsystem will chose "I2C 0".  ...and then when the main
>> SoC i2c bus registers itself it will fail because i2c0 is already
>> taken.
>>
>> By having a of_node for the hdmi i2c bus, we can assign a number to it like:
>>   i2c15 = &hdmi;
>>
>> This is all described in the two links I referenced in my original reply.
>>
>>
>> A possible other option is to have the i2c subsystem try to start
>> numbering at a larger base for all automatically numbered busses
>> (those that didn't specify a number).  Then it's more likely (though
>> still not guaranteed) to conflict with another bus...
>
> Could you please check if commit 03bde7c31a3 serves you?

I'm 99.9% certain that it's the right fix.  Sorry I wasn't aware of it.  :(

Personally I still think that it is correct to add "adap->dev.of_node
= hdmi->dev->of_node;", but I won't yell if you don't.  ;)  While
Russell's concerns are valid, my reading of his email was "there's no
actual bug caused by doing this, but it's a bad idea in general to
copy of_node".  From my research into all other i2c busses, it appears
that it is the convention to copy the of_node in the case of creating
an i2c device.  ...so since there is no actual bug, following
convention seems like the right move.  When someone fixes all the i2c
busses because they have a patch making this work better then we
should fix your i2c bus too.

...anyway, maybe that's too pragmatic of an opinion, but it is my
opinion nonetheless.  ;)


-Doug
