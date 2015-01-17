From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 16 Jan 2015 16:26:59 -0800
Subject: [PATCHv7 2/2] arm64: add better page protections to arm64
In-Reply-To: <CAKv+Gu8iGAPpR49EQKwmOZp2cHGdg8QJyoh2x1BB9uW6-S5L4g@mail.gmail.com>
References: <1421276394-20402-1-git-send-email-lauraa@codeaurora.org>	<1421276394-20402-3-git-send-email-lauraa@codeaurora.org>
 <CAKv+Gu8iGAPpR49EQKwmOZp2cHGdg8QJyoh2x1BB9uW6-S5L4g@mail.gmail.com>
Message-ID: <54B9AC53.8020903@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2015 1:44 AM, Ard Biesheuvel wrote:
> On 14 January 2015 at 22:59, Laura Abbott <lauraa@codeaurora.org> wrote:
>> Add page protections for arm64 similar to those in arm.
>> This is for security reasons to prevent certain classes
>> of exploits. The current method:
>>
>> - Map all memory as either RWX or RW. We round to the nearest
>>    section to avoid creating page tables before everything is mapped
>> - Once everything is mapped, if either end of the RWX section should
>>    not be X, we split the PMD and remap as necessary
>> - When initmem is to be freed, we change the permissions back to
>>    RW (using stop machine if necessary to flush the TLB)
>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>    read only.
>>
>> Tested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>> v7: Rebased on Ard's patch series. Addressed minor comments from
>> Catalin.
>> ---
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> With setting DEBUG_RODATA, I lose the ability to write to variables in
> the rodata section. I have not tested executing from !X sections
> though.
>
> My single objection to this patch would be that it is presented as a
> debug option, which I think is a mistake. Especially now, we are in a
> time window with lots of momentum in the arm64 kernel developer
> community and little hardware in the field yet, so we have a huge
> opportunity to make features such as this one opt-out rather than
> opt-in, without having to worry about backward compatibility. This
> applies equally to STRICT_DEVMEM, for instance, which is something
> that is on our radar at Linaro, and will be addressed in the 3.21
> timeframe.
>

I agree. I fully support making this default on if possible. My goal
for the first pass was to get the infrastructure in and then figure
out how to make this default later.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
