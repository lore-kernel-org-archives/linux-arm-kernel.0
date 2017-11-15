From: maninder1.s@samsung.com (Maninder Singh)
Date: Wed, 15 Nov 2017 11:09:22 +0000
Subject: [PATCH 1/1] arm/stacktrace: stop unwinding after an invalid
 address.
In-Reply-To: <20171024115338.GF20805@n2100.armlinux.org.uk>
References: <20171024115338.GF20805@n2100.armlinux.org.uk>
 <1508845602-33508-1-git-send-email-maninder1.s@samsung.com>
 <CGME20171024114852epcas5p199ffd8d75fc57e46d46025e12180c156@epcms5p2>
Message-ID: <20171115110922epcms5p28a7a3bdf40777fe5852c7d5bd08ec7a4@epcms5p2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

>On Tue, Oct 24, 2017 at 05:16:42PM +0530, Maninder Singh wrote:
>> This patch stops unwinding backtrace in case of below 2 cases.
>> 
>> (Issue observed while porting stackdepot on ARM, duplicate
>> entries created in stackdepot
>> reference patch for workaround in stackdepot:-
>> https://lkml.org/lkml/2017/10/11/353
>> ).
>> 
>> 1. If address belongs to irq/exception code, ignore it.
>> save_stack+0x40/0xec
>>  __set_page_owner+0x2c/0x64
>> ....
>> ....
>>  __handle_domain_irq+0x9c/0x130
>>  gic_handle_irq+0x40/0x80
>>  __irq_usr+0x4c/0x60
>>  0xb6507818
>> ^^^^^^^
>
>However, we _do_ want to trace through an IRQ taken in SVC mode, but you
>completely remove all that code.  So, not taking this patch, sorry.

OK. Thanks.

But can we add some marker to distinguish before and after interrupt context frames.
so that we can remove interrupt that frames from stackdepot, because due to interrupt allocations,
we end up with so many stackdepot entries and which results in more memory consumption by stackdepot.

Something like below:
__set_page_owner+0x2c/0x64
...
...
__handle_domain_irq+0x9c/0x130
gic_handle_irq+0x40/0x80
__irq_usr+0x4c/0x60
0xFFFFFFFF (marker)
0xb6507818
....


Thus in stackdepot we can save before 0xFFFFFFF.
or can you provide any suggestion for the same if we can try for?
