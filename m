From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 16 Mar 2016 14:52:33 +0100
Subject: [PATCH v3 6/8] arm64: dts: rockchip: Add power key to GeekBox
In-Reply-To: <56E93C43.1060500@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <1457294038-14243-7-git-send-email-afaerber@suse.de>
 <6BD669A2-4971-4702-8742-77C9994AA4E9@gmail.com> <56E93C43.1060500@suse.de>
Message-ID: <56E96521.40304@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 16.03.2016 um 11:58 schrieb Andreas F?rber:
> Am 11.03.2016 um 00:04 schrieb Julien Chauveau:
>>> @@ -70,6 +71,19 @@
>>> 		pinctrl-0 = <&ir_int>;
>>> 	};
>>>
>>> +	keys: gpio-keys {
[...]
>>> +		compatible = "gpio-keys";
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pwr_key>;
>>> +
>>> +		button at 0 {
[...]
>>> +			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
>>> +			label = "GPIO Power";
>>> +			linux,code = <KEY_POWER>;
>>
>> According to Documentation/input/event-codes.txt, there?s a special event type for the power button.
>> Should we use it here for that purpose?
>>
>> 			linux,input-type = <EV_PWR>
> 
> The other RK3368 boards don't, so unless you can give a justification to
> convert all boards yet again and test how this makes a difference, I'd
> rather not do experiments here but leave that to someone who knows what
> they're doing and then do it consistently...

For the record here's an evtest log:

geekbox:~ # evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      gpio_ir_recv
/dev/input/event1:      MCE IR Keyboard/Mouse (gpio-rc-recv)
/dev/input/event2:      gpio-keys
Select the device event number [0-2]: 2
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
Input device name: "gpio-keys"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 116 (KEY_POWER)
Properties:
Testing ... (interrupt to exit)
Event: time 1458136008.850429, type 1 (EV_KEY), code 116 (KEY_POWER),
value 1
Event: time 1458136008.850429, -------------- SYN_REPORT ------------

systemd then goes on to shut down the system cleanly.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
