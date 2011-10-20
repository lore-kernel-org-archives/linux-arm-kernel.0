From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 20 Oct 2011 14:09:22 +0530
Subject: [PATCH v7 21/21] OMAP2+: UART: Do not gate uart clocks if used
	for debug_prints
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
References: <1318952141-10697-1-git-send-email-govindraj.raja@ti.com>
	<1318952141-10697-2-git-send-email-govindraj.raja@ti.com>
	<B85A65D85D7EB246BE421B3FB0FBB593032869342E@dbde02.ent.ti.com>
	<CAAL8m4wKu8w2iTBXmtekD09RaD200qFAG6jH=RgdmjJ2uuX8cA@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930328693855@dbde02.ent.ti.com>
Message-ID: <CAAL8m4ztvsGiJz_2uPd8rtEYSsVv24oSPi4eK==U30k==75muA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2011 at 7:50 PM, Mohammed, Afzal <afzal@ti.com> wrote:
> Hi Govindraj,
>
> On Wed, Oct 19, 2011 at 18:22:58, Govindraj wrote:
>> On Wed, Oct 19, 2011 at 11:05 AM, Mohammed, Afzal <afzal@ti.com> wrote:
>> > Hi Govindraj,
>> >
>> > On Tue, Oct 18, 2011 at 21:05:41, R, Govindraj wrote:
>> >> If OMAP UART is used as console uart and debug is enabled,
>> >> avoid gating of uart clocks to print all debug prints.
>> > :
>> > :
>> >> ? ? ? ? ? ? ? ? ? ? ? console_uart_id = uart->num;
>> >>
>> >> + ? ? ? ? ? ? ? ? ? ? if (cmdline_find_option("debug")) {
>> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? uart_debug = true;
>> >
>> > Shouldn't "loglevel" also be checked?
>> >
>>
>> Might not be necessary,
>>
>> loglevel only sets the option in console driver how a printk should be handled
>> from vprintk so any printk should be to sent to console or to syslogd action
>> where it will be buffered to a file(var/log/messages).
>>
>> Any print's with any log level should be handled and printed to console.
>>
>> consider below path below path
>>
>> uart->ops
>> ?-> runtime_get_sync
>> ? ? ? -> omap_device_enable
>> ? ? ? ? ? -> clock_enable
>>
>> All the prints in given path are dev_dbgs for which we need debug to be set from
>> command line argument.
>>
>> As stated in change log any dev_dbg prints from these path can be
>> redirect to uart->ops
>> so even before our clock was enabled we got redirected back to uart code.
>>
>> So for dev_dbg prints from above path we need debug to be set from command-line
>> and we can prevent uart clock gating to this scenario.
>
> Isn't passing bootargs "loglevel=10" same as "debug"? (init/main.c)

Yes correct, I missed that part here is the updated patch [1]
Updated change-log for debug/loglevel and checked console_loglevel
in addition to debug in bootargs.

Same is updated in the branch hosted for v7_runtime:
https://gitorious.org/runtime_3-0/runtime_3-0/commit/3775d72f1205d218eb423a83ed87afe4c643ef38

git://gitorious.org/runtime_3-0/runtime_3-0.git v7_rc9_uart_runtime

--
Thanks,
Govindraj.R

[1]:
