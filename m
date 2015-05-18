From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 18 May 2015 20:43:27 +0200
Subject: [PATCH v4 0/6] SA1100/PXA RTC clean-up
In-Reply-To: <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
 (Rob Herring's message of "Mon, 18 May 2015 08:18:00 -0500")
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
 <87pp62jdpj.fsf@belgarion.home>
 <CAL_JsqJ-VMQHXFF9Gxf5mmPjYXZ6gyktYFjgvxAHRx-Kmuoq8A@mail.gmail.com>
Message-ID: <877fs5k9ps.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Fri, May 15, 2015 at 6:13 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Rob Herring <robh@kernel.org> writes:
>>
>>> A git branch is here[4]. I've tested sa1100-rtc on PXA1928. I need help
>>> testing on PXA27x/3xx.
>> Hi Rob,
>>
>> I tested on PXA27x. It works for the boards which used pxa-rtc.
>> For the others, their defconfig become broken, because the pxa boards with
>> sa1100-rtc do not work anymore. And of course no .config manipulation will fix
>> this, because PXA architecture is denied the sa1100-rtc driver.
>
> Ah, I didn't realize there is a mixture of use.
>
> I could just do something like this instead of removing
> sa1100_device_rtc registration:
>
> #ifndef CONFIG_RTC_DRV_PXA
>        &sa1100_device_rtc,
> #else
>         &pxa_device_rtc,
> #endif
I ... don't like that much, especially when you consider both rtc might be
modules for example. I rather like that patch in pxa as they are.

I'm rather in a mood for a more aggressive approach :

 - you fire an incremental patch to patch the 10 defconfigs on PXA architecture
   (pxa27x and pxa3xx)
 - in this patch, you replace 's/CONFIG_RTC_DRV_SA1100/CONFIG_RTC_DRV_PXA/'
 - you send this patch to the maintainers and me
 - you explain in the commit message that from a userland perspective, nothing
   changes, except that the RTC IP will change, and any dependency on a
   bootloader fidling with RTC should be considered as a source of regression.
   Moreover the first reboot will have the wrong date, until it is set.

After that, if no board maintainer complains, or doesn't answer (and therefore
doesn't care), and you have my blessing to make the switch. If one complains and
demonstrates why this change might break his board, we'll see.

Cheers.

-- 
Robert
