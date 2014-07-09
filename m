From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 9 Jul 2014 15:38:00 -0700
Subject: [PATCH v8 4/4] drivers: net: Add APM X-Gene SoC ethernet driver
 support.
In-Reply-To: <20140624.223442.1599243407487139839.davem@davemloft.net>
References: <1403306296-26198-1-git-send-email-isubramanian@apm.com>
 <1403306296-26198-5-git-send-email-isubramanian@apm.com>
 <20140624.223442.1599243407487139839.davem@davemloft.net>
Message-ID: <CAKh23FnraikR3apUtrxOWYransQYEFVVJcSaL9d6OWzeWiVT1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 10:34 PM, David Miller <davem@davemloft.net> wrote:
> From: Iyappan Subramanian <isubramanian@apm.com>
> Date: Fri, 20 Jun 2014 16:18:16 -0700
>
>> This patch adds network driver for APM X-Gene SoC ethernet.
>>
>> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
>> Signed-off-by: Ravi Patel <rapatel@apm.com>
>> Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
>
> I really don't like how you handle the hardware descriptors in this
> driver.
>
> You copy back and forth between a software format and the hardware
> format.  That's extremely wasteful and will hurt performance.
>
> Just use the raw format throughout, you can extract the fields when
> you need them.

I agree and I will fix this and resubmit the patches.

>
> You also make two passes when building a hardware descriptor:
>
> 1) write the values
> 2) endian swap
>
> This means you make three memory accesses on every 64-bit word
> in every descriptor you setup, this is really inefficient.
>
> You should just byte swap them in-situ as you build the raw
> descriptors.
