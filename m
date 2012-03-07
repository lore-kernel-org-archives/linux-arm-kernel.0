From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 07 Mar 2012 11:48:24 +0100
Subject: [PATCH v3] MM: CMA: add a simple kernel module as the helper to
 test CMA
In-Reply-To: <4F56E0AC.8070501@gmail.com>
References: <1331090098-25097-1-git-send-email-Barry.Song@csr.com>
 <4F56E0AC.8070501@gmail.com>
Message-ID: <op.wasqyyok3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 03/07/2012 11:14 AM, Barry Song wrote:
>> Any write request to /dev/cma_test will let the module to allocate memory from
>> CMA, for example:
>>
>> 1st time
>> $ echo 1024>  /dev/cma_test
>> will require cma_test to request 1MB(1024KB)
>> 2nd time
>> $ echo 2048>  /dev/cma_test
>> will require cma_test to request 2MB(2048KB)
>>
>> Any read request to /dev/cma_test will let the module to free the 1st valid
>> memory from CMA, for example:
>>
>> 1st time
>> $ cat /dev/cma_test
>> will require cma_test to free the 1MB allocated in the first write request
>> 2nd time
>> $ cat /dev/cma_test
>> will require cma_test to free the 2MB allocated in the second write request

On Wed, 07 Mar 2012 05:14:36 +0100, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> Any reason why using /dev not /proc or /sys?

Because /proc is for processes and /sys is for stable, documented APIs.

If anything, debugfs might make some sense, but since the module needs struct
device anyway, it can just register a misc device, which is simpler and does
not require debugfs to be compiled.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
