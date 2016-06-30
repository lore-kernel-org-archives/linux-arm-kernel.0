From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Thu, 30 Jun 2016 21:23:56 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm, nvram_file_name
 dt property
In-Reply-To: <3960223.GqB9zXL8s8@wuerfel>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <CAOiHx==82LHOeQMNVD+dybFifXX690Q6AJTcMBMynjSfUOyGUw@mail.gmail.com>
 <8d8bd933-717b-48e4-f002-7b834abed6fd@redhat.com>
 <3960223.GqB9zXL8s8@wuerfel>
Message-ID: <1f44df41-0111-441b-4671-718eec0c4346@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30-6-2016 13:31, Arnd Bergmann wrote:
> On Thursday, June 30, 2016 12:25:15 PM CEST Hans de Goede wrote:
>>> So then how about making use of a more specific compatible string?
>>>
>>> e.g.
>>>
>>> brcmf {
>>>         compatible = "foo,ap6210", "brcm,bcm4329-fmac";
>>>         ...
>>> };
>>>
>>> and if the compatible has more than one element you request
>>> FW_NAME_<compatible>.txt as the nvram file. Or try each comptible (and
>>> lastly no suffix) until you get a match. (AFAICT, this is what the
>>> "model" property was originally intended for anyway, but almost nobody
>>> did it right, and everyone put a user readable string into "model" for
>>> boards instead of the ePAPR defined compatible string).
>>
>> Hmm, interesting idea. Not sure how easy / hard it will be to implement
>> this, but from a dt binding point of view it seems elegant.
>>
>> Kalle, Arend, what do you think of this ?

At first glance I like the suggestion, but this would mean updating the
bindings document for each new wifi module that we want to add. Not a
big problem, but it makes that I have a slight preference to using a
property for it, eg. brcm,module = "ap6210";

> I think that's reasonable. Also, we have precedent for using things like
> the boardid as part of the compatible string, which would help do what
> Kalle suggested earlier with "nvram-<boardtype>-<boardrev>.txt",
> as we get that for free by trying out all the compatible strings.

The suggestion from Kalle was to use the field in the nvram file, but
things are a bit more complicated. The fields are only used if it is not
stored on the device in OTP or SROM. The 43362 does not have a SROM, but
it still has a small OTP storage if I am not mistaken. The brcmfmac
exposes a revinfo file in debugfs containing boardtype and boardrev, but
that is after starting the firmware. Still worth to check if those
values match the values in the ap6210 nvram file.

Regards,
Arend
