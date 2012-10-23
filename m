From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Tue, 23 Oct 2012 14:53:48 +0200
Subject: pxa:spitz_pm.c: commit b6eede11 breaks spitz resume under certain
 conditions.
In-Reply-To: <CAMPhdO9PFfHDWL6sx+4O4LYtTBXoT7QRTQq=t6YhQ+C7GT8UBQ@mail.gmail.com>
References: <CAHod+GeMyc+5ERmzY4CYp3SJK-6LOQrhLrLiXSuV3Pdr8+UzSg@mail.gmail.com>
 <CAMPhdO-6iWUWm=vTp-e25BkYBuM5kQfxNW57xKNtKDRU-5Ymgw@mail.gmail.com>
 <CAHod+Gc1L0pPZhnPL6Q2rx0KT=-VqdWaTd1FJt2aA9hTMZyeDg@mail.gmail.com>
 <CAMPhdO8duNqisVL+FLc_0zgFTP+13r83XtRD0YbpdkzMuJov3Q@mail.gmail.com>
 <CAHod+Gd=aLbntWsX_S_26_XSUtG9DQYkki1Y+drq0+8GdnHfaw@mail.gmail.com>
 <CAHod+GcwNr6r_ZQFq-btPJ3E_keWKJhkCb2jP4CES6JTSyn8ow@mail.gmail.com>
 <CAHod+GfycPnugk0UF6aqFUb4UJwZRM_PHPiSDpGSbF3OXSwMLw@mail.gmail.com>
 <CAMPhdO9PFfHDWL6sx+4O4LYtTBXoT7QRTQq=t6YhQ+C7GT8UBQ@mail.gmail.com>
Message-ID: <CAHod+GfMArh3BrnOTV4VWNWDONLwdyr6V69tTV-Fk53kpXu0Pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 5:10 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Oct 19, 2012 at 7:37 PM, Marko Kati? <dromede@gmail.com> wrote:
>> On Thu, Oct 18, 2012 at 11:28 AM, Marko Kati? <dromede@gmail.com> wrote:
>>>> Almost there, but I guess we could do this better and less confusing by having
>>>> another array, e.g. tosa_gpio18_config[], which is tosa specific, and only
>>>> initialize that MFP setting in the tosa path.
>>>>
>>>>>
>>>>> I also looked at the original sharp kernel sources.
>>>>> Only tosa used the RDY signal for it's tc6393tx chip, other machines simply
>>>>> configured gpio18 as output in their suspend routines.
>>>
>>>
>>> Actually, tosa doesn't use sharpsl_pm. Tosa uses the pda-power framework.
>>> I said that only tosa uses the RDY signal to point out that we
>>> probably don't need
>>> the mfp-config line in postsuspend. That being said, i still think
>>> that the array ordering
>>> fix is adequate. Maybe later we may remove the mfp-config line from
>>> postsuspend when
>>> we're absolutely sure it isn't necessary for devices that use spitz_pm.c.
>>
>> So Eric what do you think, is the simple gpio array reordering patch
>> an adequate fix for this bug?
>
> Sorry for late reply. That simple reordering still looks a bit confusing
> to me, i.e. the same pin firstly configured as GPIO then RDY. Do we
> have a less confusing way to fix this?

well, we could also remove the mfp-config line in postsuspend. I
suspect that it's only there because tosa was supposed to use
sharpsl_pm and it currently doesn't (and certainly never will). And as
i said, the original sharp kernels never did configure gpio 18 as RDY,
except for tosa.
