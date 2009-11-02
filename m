From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Nov 2009 06:48:28 -0400
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091102093840.GA11426@elf.ucw.cz>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
	<20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<20091102093840.GA11426@elf.ucw.cz>
Message-ID: <771cded00911020248s2b2b6577o5ec2f3772a09e7b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2009 at 5:38 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2009-11-02 05:22:30, Haojian Zhuang wrote:
>> On Sun, Nov 1, 2009 at 6:03 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>
>> Em, it's not caused by the IRQ patch.
>>
>> The kernel is blocked in resume path. When console is resumed, IRQ is
>> already disabled and system is blocked. Actually, IRQ shouldn't be
>> disabled at here. Up to now, I only find which patch will cause this
>> issue. But I can't find the best solution on it. The patch with issue
>> is pasted in below.
>>
>> So this issue is only occused when console suspend is enabled. If you
>> enable no_console_suspend in command, you won't meet this issue. It
>> seems that it's caused by removing termios setting in
>> uart_resume_port() in the below patch. If I add these code back, the
>> issue doesn't occur any more.
>
> Given that it hangs very early, in arch_suspend_enable_irqs() (see my
> other mail), I don't trust your analysis.
>
> I'm not using serial console on spitz, and I have never had successful
> resume with the patch applied.

It seems that we're talking on different issue with similar symptom.
Please check my test method. While I'm testing suspend with devices
level, kernel is blocked in console resume. In this level, it won't
call arch_suspend_enable_irqs(). This function call is only invoked in
processor level or below.

Up to now, I can't reproduce the issue you're talking on my platform
yet. I'll check this issue continuously. I also want to know your
hardware information.

Thanks
Haojian
