From: julian.calaby@gmail.com (Julian Calaby)
Date: Thu, 13 Nov 2014 19:47:30 +1100
Subject: [linux-sunxi] [PATCH 2/4] simplefb: Add support for enumerating
 simplefb dt nodes in /chosen
In-Reply-To: <54646E83.9070704@redhat.com>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-2-git-send-email-hdegoede@redhat.com>
 <CAGRGNgW_Q6oghpe5Mw-8aYPVVj1YZ6R3iaqOQzCE9dSD1nYSyA@mail.gmail.com>
 <54646B5B.1070604@redhat.com>
 <CAMuHMdVSfYyHc52Tdu_wzb6ZYPzeZtOzweUwADHxiJLypuBQNw@mail.gmail.com>
 <54646E83.9070704@redhat.com>
Message-ID: <CAGRGNgVjZCY2+A5fs54bu=JWQJa=fzBSrC_3VYa1dcOydxXw0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Thu, Nov 13, 2014 at 7:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 11/13/2014 09:34 AM, Geert Uytterhoeven wrote:
>> Hi Hans,
>>
>> On Thu, Nov 13, 2014 at 9:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>> +       char name[16];
>>>>> +       struct device_node *np;
>>>>> +
>>>>> +       ret = platform_driver_register(&simplefb_driver);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       for (i = 0; ; i++) {
>>>>> +               snprintf(name, sizeof(name), "framebuffer%d", i);
>>>>
>>>> This smells like an infinite loop: we can be pretty sure that no
>>>> hardware will ever exist with more than 9999 (I think?) framebuffers,
>>>> however if that ever happens this'll loop until it runs out of RAM.
>>>> Maybe add a suitably high limit to the for loop?
>>>
>>> The loop will stop as soon as there are no more framebuffer# nodes in chosen,
>>> so the loop is only infinite if there are infinite nodes in the devicetree,
>>> which would make the devicetree infinitely large, so this will never happen.
>>
>> If there are 10000 frame buffers, the loop will continue beyond that,
>> as the index will be truncated to 4 digits due to the size of name[].
>> It will stop when (signed) i becomes negative, though ;-)
>>
>> One solution is to increase the size of name[],
>
> This is probably never going to happen, but I'll increase the size of name in v2
> anyways.

You could also just limit it to 100 or something like that.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
