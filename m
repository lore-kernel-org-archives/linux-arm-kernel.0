From: eric.miao@canonical.com (Eric Miao)
Date: Wed, 7 Jul 2010 22:14:12 +0800
Subject: [PATCH RFC] Introduce one machine_desc instance and
	get_machine_desc()
In-Reply-To: <alpine.LFD.2.00.1007070918320.6020@xanadu.home>
References: <AANLkTinWPkI2zVCVw_yx87WVuAGZuWpBUuvGbxx_luIr@mail.gmail.com>
	<alpine.LFD.2.00.1007070918320.6020@xanadu.home>
Message-ID: <AANLkTinxZYUrIva6vOVwTY3yDDl5ziAI4Jhx1UJsYssn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 7, 2010 at 9:32 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 7 Jul 2010, Eric Miao wrote:
>
>> commit 5d5d90e5d41bb0842559dd2b00f00f2a0f532a3a
>> Author: Eric Miao <eric.miao@canonical.com>
>> Date: ? Wed Jul 7 16:47:20 2010 +0800
>>
>> ? ? [ARM] Introduce one machine_desc instance and get_machine_desc()
>>
>> ? ? If some of the fields remains useful in 'struct machine_desc', it's
>> ? ? normally a bit convenient to keep one instance there for reference.
>>
>> ? ? (along with more and more machine specific fields coming into this
>> ? ? structure, e.g. pcibios_min_{io,mem})
>>
>> ? ? It also improves modularity a bit by not exporting variables like
>> ? ? system_timer, init_arch_irq etc.
>>
>> ? ? However, the drawbacks are 1) a bit increased data and 2) increased
>> ? ? risk of accessing those fields which are marked as __init.
>
> That makes me worried. ?Access to __init data/functions after __init
> stuff is freed is amongst the nastiest subtle bugs that are hard to
> reproduce and therefore fix. ?And copying such pointers is probably
> defeating the simple compile time checks we currently have against that.

Indeed I was upset as well :-)

>
> Maybe those fields should be partitioned differently. ?Having a new
> structure to encapsulate all fields that should be kept after __init
> stuff is gone might be a better way.

That's going to invent another similar structure and produce more code
when copying over. What about keeping those __init function pointers
as NULL, and copying the rest?

>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
