From: khilman@ti.com (Kevin Hilman)
Date: Wed, 18 Apr 2012 07:21:33 -0700
Subject: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by
 default
In-Reply-To: <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
 (Govindraj Raja's message of "Wed, 18 Apr 2012 18:46:31 +0530")
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
 <87vckyq6ti.fsf@ti.com>
 <CAMrsUdL1S5GiyG0egS=CHg2fdNkyZVF-wuCNGDg547kfTUODng@mail.gmail.com>
Message-ID: <87mx69nms2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Raja, Govindraj" <govindraj.raja@ti.com> writes:

> On Wed, Apr 18, 2012 at 4:55 AM, Kevin Hilman <khilman@ti.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>>
>>> The wakeups can be left enabled by default and should be disabled
>>> only when disabled from sysfs and while entering suspend.
>>
>> Left enabled? ?That assumes something else has initizlied them, but we
>> can't make that assumption.
>>
>> First, wakeups should be disabled when ->probe has finished. ?Then,
>> they should be enabled whenever driver is in use, and disabled when
>> the driver is not in use.
>>
>> I'm not familiar enough with uart_ops, but it looks like they should
>> probably be enabled in uart_ops->startup and disabled in
>> uart_ops->shutdown.
>
> uart_ops->shutdown gets called in suspend path also
> serial_omap_suspend => uart_suspend_port = > ops->shutdown(uport);
>
> This will leave uart wakeup disabled in suspend path.

As I said, I'm not familiar enough with uart_ops to know which are the
right ones.

Maybe ->request_port and ->release_port are the right ones?

The point is that wakeups should be enabled whenever driver is in use,
and disabled when the driver is not in use.

Kevin
