From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 24 Oct 2014 14:55:23 +0100
Subject: [PATCH 6/6] arm64/efi: remove idmap manipulations from UEFI code
In-Reply-To: <CAKv+Gu8x3GGo=GeMWK4P8grTmZPq6dh3K-WZDmaWq=G-cKJhNA@mail.gmail.com>
References: <1414154384-15385-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414154384-15385-7-git-send-email-ard.biesheuvel@linaro.org>
 <CACxGe6uc9VZs4fMS+U9W=wG3bJr2pm=tREQsqvF91LgKdsXjqw@mail.gmail.com>
 <CAKv+Gu8x3GGo=GeMWK4P8grTmZPq6dh3K-WZDmaWq=G-cKJhNA@mail.gmail.com>
Message-ID: <CACxGe6uAm0JN9qJscp2yuLACMYAAMJPK2er=4g48E6xzrGRhcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 2:53 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 24 October 2014 15:41, Grant Likely <grant.likely@linaro.org> wrote:
>> On Fri, Oct 24, 2014 at 1:39 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> Now that we have moved the call to SetVirtualAddressMap() to the stub,
>>> UEFI has no use for the ID map, so we can drop the code that installs
>>> ID mappings for UEFI memory regions.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> I have to say, this series makes me happy. :-)
>>
>> This method will go a long way to catching UEFI implementations that
>> do incorrect things after exitbootservices is called. I'm assuming
>> that any attempt to access a region that boot services has not
>> requested will get trapped by the kernel, correct?
>>
>
> If we really want to catch firmware problems, we should probably wipe
> all boot services regions between the calls to ExitBootServices() and
> SetVirtualAddressMap(). Mark Salter's original approach here was
> fairly cautious here, i.e., reserving boot services regions until
> after the call to SetVirtualAddressMap(), but there is no point in
> doing that for kexec, that's why I removed it.

I quite like that idea. Let's do that and see if anyone screams in agony.

g.
