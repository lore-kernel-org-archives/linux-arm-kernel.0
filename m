From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Jan 2015 23:55:26 +0800
Subject: sun9i pll4 upstream kernel code seems wrong
In-Reply-To: <54BA55D3.4000507@redhat.com>
References: <54BA2C96.7050102@redhat.com>
 <CAGb2v66j8=VNkX_C=aEEO0cq53ELGnkZoNSk=wCy8n5j0w0mWw@mail.gmail.com>
 <54BA4395.4060403@redhat.com> <54BA444B.7050304@redhat.com>
 <CAGb2v670DxyAjzA8vN-Wed_jN=LLix9r1mWeqW0JpYGZCg4i_Q@mail.gmail.com>
 <54BA55D3.4000507@redhat.com>
Message-ID: <CAGb2v66fXh860DxrSFhJmqF9V_+hFr1GJD970K1sggn_kW4a9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 8:30 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 17-01-15 13:09, Chen-Yu Tsai wrote:
>>
>> Hi,
>>
>> On Sat, Jan 17, 2015 at 7:15 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On 17-01-15 12:12, Hans de Goede wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 17-01-15 11:37, Chen-Yu Tsai wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Sat, Jan 17, 2015 at 5:34 PM, Hans de Goede <hdegoede@redhat.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> Hi ChenYu,
>>>>>>
>>>>>> Looking at drivers/clk/sunxi/clk-sun9i-core.c:
>>>>>>
>>>>>> sun9i_a80_get_pll4_factors(), and comparing it with
>>>>>> the A80 user manual, things seem way off, this seems
>>>>>> more accurate (although also possibly not quite)
>>>>>> for pll1 / pll2 then for pll4, and the comment at
>>>>>> the top does mention PLL1 once.
>>>>>
>>>>>
>>>>>
>>>>> PLL1 was mentioned as I forgot to change that one in
>>>>> the comment. I copied the comment section from others.
>>>>>
>>>>> Other than that, I'm not sure what part is off. The
>>>>> code was done without the user manual, only with the
>>>>> SDK bits. I think in the SDK the minimum value of 12
>>>>> for N factor was not mentioned. But other than that,
>>>>> it should work fine.
>>>>
>>>>
>>>>
>>>> Ok, so looking at the code again it is not that much
>>>> of, just hard to read, and it does contain some errors:
>>>>
>>>>           /* divs above 256 cannot be odd */
>>>>           if (div > 256)
>>>>                   div = round_up(div, 2);
>>>>
>>>> Should be:
>>>>
>>>>           /* divs above 255 must be a multiple of 2 */
>>>>           if (div > 255)
>>>>                   div = round_up(div, 2);
>>>>
>>>> Note the 255, and replacing must be odd with
>>>> a multiple of 2, as this had nothing to do with odd /
>>>> even (more on that later).
>>>>
>>>> Likewise this:
>>>>
>>>>       /* divs above 512 must be a multiple of 4 */
>>>>           if (div > 512)
>>>>                   div = round_up(div, 4);
>>>>
>>>> Should have s/512/511/ done on it.
>>>>
>>>> And this:
>>>>
>>>>           /* m will be 1 if div is odd */
>>>>           if (div & 1)
>>>>                   *m = 1;
>>>>           else
>>>>                   *m = 0;
>>>>
>>>> Is nonsense, the div may have been odd all along,
>>>> (never been rounded) and we should still use m = 1, e.g.
>>>> to make 78 MHz.
>>>
>>>
>>>
>>> Correction this should read:
>>>
>>> Is nonsense, the div may have been *even* all along,
>>> (never been rounded) and we should still use m = 1, e.g.
>>> to make *72* MHz.
>>
>>
>> The m and p constraints were based on comments in the
>> original SDK code, which weren't very clear as to if
>> they were hardware constraints or just preferred
>> behavior in the code path. Looking back, I agree the
>> work done by me here could have been better.
>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>>>
>>>> So this should be:
>>>>
>>>>           if (div < 256)
>>>>                   *m = 1;
>>>>           else
>>>>                   *m = 0;
>>>>
>>>> Preferably I would like to see the entire thing rewritten
>>>> into something IMHO much more readable / less error prone,
>>>> like this:
>>>>
>>>> {
>>>>       u8 n;
>>>>       u8 m = 1;
>>>>       u8 p = 1;
>>>>
>>>>       /* Normalize value to a 6M multiple */
>>>>       n = DIV_ROUND_UP(*freq, 6000000);
>>>>
>>>>       if (n > 255) {
>>>>           m = 0;
>>>>           n = (n + 1) / 2;
>>>>       }
>>>>
>>>>       if (n > 255) {
>>>>           p = 0;
>>>>           n = (n + 1) / 2;
>>>>       }
>>>>
>>>>       if (n > 255)
>>>>           n = 255;
>>>>       else if (n < 12)
>>>>           n = 12;
>>>>
>>>>       *freq = ((24000000 * n) >> p) / (m + 1);
>>>>
>>>>       if (n_ret == NULL)
>>>>           return;
>>>>
>>>>       *n_ret = n;
>>>>       *m_ret = m;
>>>>       *p_ret = p;
>>>> }
>>>>
>>>> With the n / m / p function parameters renamed to foo_ret.
>>
>>
>> Since you've pretty much wrote the whole function, would
>> you send a patch out when you get the chance?
>
>
> Sure, the reason I was proposing this by mail first was to
> see if you agree that something like the above will be better,
> if you agree I'll turn this into a patch.

I say go for it. I'm a bit busy with travel preparations and
other stuff this week, so I haven't tested the sample above.


ChenYu
