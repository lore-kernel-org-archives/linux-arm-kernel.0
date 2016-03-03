From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 3 Mar 2016 17:36:22 +0100
Subject: [PATCH v13 4/6] arm64: Move unflatten_device_tree() call earlier.
In-Reply-To: <56D86761.9060905@caviumnetworks.com>
References: <1456959362-2036-1-git-send-email-ddaney.cavm@gmail.com>
 <1456959362-2036-5-git-send-email-ddaney.cavm@gmail.com>
 <CAL_JsqL0Mzgp_SkycmiZBbt2OoGtE7_rFgD41Jex4nDS7xXrHA@mail.gmail.com>
 <56D86761.9060905@caviumnetworks.com>
Message-ID: <CAKv+Gu-em9b8gUqP5sry7_ztQipQiyPKURtw3AmAVdhJ9M67dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2016 at 17:33, David Daney <ddaney@caviumnetworks.com> wrote:
> On 03/03/2016 05:47 AM, Rob Herring wrote:
>>
>> On Wed, Mar 2, 2016 at 4:56 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>>
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> In order to extract NUMA information from the device tree, we need to
>>> have the tree in its unflattened form.
>>>
>>> Move the call to unflatten_device_tree() into paging_init().  This
>>> puts it before the call to bootmem_init(), which is where the NUMA
>>> information is extracted.
>>
>>
>> Can't you just move up unflatten_device_tree in setup_arch rather than
>> hiding in paging_init?
>
>
> No.
>
> It must come *after* map_mem() and *before* bootmem_init(), both of which
> are done within paging_init().
>
> One option would be to split the things in paging_init() into two functions,
> and then do:
>
> .
> .
> .
>    paging_init_first_part();
>    if (acpi_disabled)
>        unflatten_device_tree();
>    paging_init_second_part();
> .

I think it makes more sense to move bootmem_init() to setup_arch() then
