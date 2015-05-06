From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Wed, 6 May 2015 14:56:58 +0800
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <5548A5D5.9030107@linaro.org>
References: <55417F5A.4040300@linaro.org> <2490159.r1U8jHTvO3@wuerfel>
 <CAMJs5B9V_tWxut6LLWDdpN1m9NsaC_JGfR_U_SHN=OOhdHe_Yw@mail.gmail.com>
 <9143918.xCQ8d3X4XD@wuerfel> <5548A5D5.9030107@linaro.org>
Message-ID: <5549BB3A.6060106@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/5 19:13, Shannon Zhao wrote:
> 
> 
> On 2015/5/5 18:55, Arnd Bergmann wrote:
>> On Tuesday 05 May 2015 12:51:57 Christoffer Dall wrote:
>>> On Tue, May 5, 2015 at 11:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Tuesday 05 May 2015 12:27:54 Joel Stanley wrote:
>>>>
>>> Do ARM distributions (Fedora, Ubuntu, Debian, ...) support the
>>> necessary userspace handling so that things work with the input
>>> subsystem?
>>
>> I think the latest releases all use systemd, so it should work in theory,
>> but I have not tried it, and I don't know if they have something else
>> on older versions.
>>
> 
> Thanks, will try to use gpio-keys and check whether systemd works.
> 

I've added a PL061 GPIO controller and gpio-keys node in QEMU like
following format:

        pl061 at 9030000 {
                phandle = <0x8002>;
                clock-names = "apb_pclk";
                clocks = <0x8000>;
                interrupts = <0x0 0x7 0x4>;
                gpio-controller;
                #gpio-cells = <0x2>;
                compatible = "arm,pl061";
                reg = <0x0 0x9030000 0x0 0x1000>;
        };
        gpio-keys {
                autorepeat;
                #address-cells = <0x1>;
                #size-cells = <0x0>;
                compatible = "gpio-keys";

                poweroff {
                        gpios = <0x8002 0x3 0x0>;
                        linux,code = <0x74>;
                        label = "GPIO Key Poweroff";
                };
        };

Configure kernel to select GPIO Buttons and Polled GPIO buttons. Use a
Redhat filesystem "Red Hat Enterprise Linux Server for ARM Development
Preview release 1.5" which has systemd and systemd-logind. Start VM and
when it starts well type "system_powerdown" on QEMU monitor, the guest
goes to poweroff. So this way works.


Note: we must check the /lib/udev/rules.d/70-power-switch.rules in the
fs and add one following line in it if it doesn't exist.

SUBSYSTEM=="input", KERNEL=="event*", SUBSYSTEMS=="platform",
ATTRS{keys}=="116", TAG+="power-switch"

Then when execute journalctl -u systemd-logind in guest, we can see
something like below:

Jan 01 00:01:02 localhost systemd[1]: Starting Login Service...
Jan 01 00:01:07 localhost systemd[1]: Started Login Service.
Jan 01 00:01:07 localhost systemd-logind[927]: Watching system buttons
on /dev/input/event0 (gpio-keys)
Jan 01 00:01:07 localhost systemd-logind[927]: New seat seat0.
Jan 01 00:01:25 localhost systemd-logind[927]: New session c1 of user root.

Visit https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1347776 for
details.

-- 
Shannon
