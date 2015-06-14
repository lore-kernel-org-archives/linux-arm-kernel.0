From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 14 Jun 2015 19:26:01 +0300
Subject: [PATCH v5 05/17] input: make LoCoMo keyboard driver support both
 poodle and collie
In-Reply-To: <20150614151106.GD7557@n2100.arm.linux.org.uk>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-6-git-send-email-dbaryshkov@gmail.com>
 <20150614151106.GD7557@n2100.arm.linux.org.uk>
Message-ID: <CALT56yOOT+Y_60c4HNHKvkBG1twrnV9aEnKKTm4GyusnEoivww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2015-06-14 18:11 GMT+03:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jun 08, 2015 at 11:56:36PM +0300, Dmitry Eremin-Solenikov wrote:
>> @@ -278,6 +281,11 @@ static int locomokbd_probe(struct platform_device *dev)
>>                       locomokbd_keycode,
>>                       sizeof(locomokbd->keycode));
>>
>> +     if (machine_is_collie())
>> +             locomokbd->keycode[18] = KEY_HOME;
>> +     else
>> +             locomokbd->keycode[3] = KEY_HOME;
>
> We had decided that we weren't allowing any new machine_is_xxx() in drivers.
> Why can't this difference be encoded via platform data, so it can be later
> encoded in DT if sa11x0 moves in that direction?

I'd agree with you. However this looks rather long path:
* Introduce platform data with just one preference (for home key).
* Switch poodle(pxa) to dts
* Switch collie(sa1100) to dts
* Introduce special property (or use compatibility string)
* Kill platform data.

By allowing machine_is_xx() here we can forget about this temporary platform
data. The change is quite isolated. If you completely disagree with this patch,
I'd prefer to just drop it for now (as it is an added feature rather
than just refactoring).

-- 
With best wishes
Dmitry
