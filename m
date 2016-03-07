From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 7 Mar 2016 22:53:05 +0530
Subject: [PATCH 1/2] net: thunderx: Set recevie buffer page usage count in
 bulk
In-Reply-To: <20160307.120410.1851177945150642006.davem@davemloft.net>
References: <1457336157-31508-2-git-send-email-sunil.kovvuri@gmail.com>
 <20160307.111534.235286977900488968.davem@davemloft.net>
 <CA+sq2CewOQGSiRC5m64ioYS36-WO0C5XzykZRZd+OLE1tJ-sSQ@mail.gmail.com>
 <20160307.120410.1851177945150642006.davem@davemloft.net>
Message-ID: <CA+sq2CcyOV3FbpUvSkX4ZhjC+fJuHk9cUpjdiJtkFNaEXOWu6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 7, 2016 at 10:34 PM, David Miller <davem@davemloft.net> wrote:
> From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
> Date: Mon, 7 Mar 2016 22:28:39 +0530
>
>> Hi David,
>>
>>>> you create a window of time during which the consumer
>>>> can release the page and prematurely free it.
>> Okay, but here the consumer i.e HW is notified only after page count
>> is incremented.
>> For example if you check 'nicvf_refill_rbdr' fn() only after receive
>> buffer ring is
>> refilled with buffers, doorbell is issued to hardware to start using
>> the new buffers.
>>
>> So
>> @@ -241,6 +254,8 @@ refill:
>>                 new_rb++;
>>         }
>>
>> +       nicvf_get_page(nic);
>> +
>> calling 'nicvf_get_page' before issuing doorbell ensures page ref
>> count is properly
>> set before hw/consumer can use the buffers.
>
> So if you know ahead of time how the page will be split up, just
> calculate that when you get the page and increment the page count
> appropriately.
>
> That's what we do in the NIU driver.

Thanks for the suggestion, will check and get back.

Regards,
Sunil.
