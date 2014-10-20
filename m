From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 20 Oct 2014 20:44:09 +0300
Subject: [PATCHv8 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <20141020170603.GG10616@piout.net>
References: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413743305-1979-2-git-send-email-alexandre.belloni@free-electrons.com>
 <54442BB1.1080403@mleia.com> <20141020102939.GB10616@piout.net>
 <544509C7.9010309@mleia.com> <20141020170603.GG10616@piout.net>
Message-ID: <544549E9.7060702@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.2014 20:06, Alexandre Belloni wrote:
> On 20/10/2014 at 16:10:31 +0300, Vladimir Zapolskiy wrote :
>> Hi Alexandre,
>>
>> On 20.10.2014 13:29, Alexandre Belloni wrote:
>>> Hi,
>>>
>>> On 20/10/2014 at 00:22:57 +0300, Vladimir Zapolskiy wrote :
>>>>> +struct sun4i_pwm_chip {
>>>>> +	struct pwm_chip chip;
>>>>> +	struct clk *clk;
>>>>> +	void __iomem *base;
>>>>> +	struct mutex ctrl_lock;
>>>>
>>>> why do you use mutex? I haven't found any blocking subcalls under
>>>> protection, a spinlock seems to fit better here.
>>>>
>>>
>>> A mutex here will do the right thing. The lock is never taken in
>>> interrupt context and a mutex is spinning for a few cycles before
>>> putting the thread to sleep.
>>
>> and why do you want to put a thread to sleep in context of the driver?
>>
> 
> Because the PWM is getting configured from either a kernel thread or a
> userspace thread accessing /sys. So you probably want the current thread
> to sleep so the other thread accessing the register can finish. Unless
> you are on smp and then, the mutex will spin for some time and your
> other cpu will be finished by then.
> 

You answer why a thread sleeps, if you use a mutex in the driver. But
you don't answer my question why do you want to put a thread to sleep.

As for me you introduce the excessive heaviness for no reason. There is
no need to sleep while waiting for completion of a register writing.

With best wishes,
Vladimir
