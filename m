From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 May 2015 12:14:00 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <5549CEAF.1090400@linaro.org>
References: <55417F5A.4040300@linaro.org> <5548A5D5.9030107@linaro.org>
 <5549BB3A.6060106@huawei.com> <2196079.901rMdSZr0@wuerfel>
 <5549CEAF.1090400@linaro.org>
Message-ID: <CAMJs5B_mmMDJQwWdd90W-sJmUrq_gBP8NBSTMNHMxU_mNHhJEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 10:19 AM, Shannon Zhao <shannon.zhao@linaro.org> wrote:
>
> On 2015/5/6 15:29, Arnd Bergmann wrote:
>> On Wednesday 06 May 2015 14:56:58 Shannon Zhao wrote:
>>> > On 2015/5/5 19:13, Shannon Zhao wrote:
>>> >         gpio-keys {
>>> >                 autorepeat;
>>> >                 #address-cells = <0x1>;
>>> >                 #size-cells = <0x0>;
>>> >                 compatible = "gpio-keys";
>>> >
>>> >                 poweroff {
>>> >                         gpios = <0x8002 0x3 0x0>;
>>> >                         linux,code = <0x74>;
>>> >                         label = "GPIO Key Poweroff";
>>> >                 };
>>> >         };
>>> >
>>> > Configure kernel to select GPIO Buttons and Polled GPIO buttons. Use a
>>> > Redhat filesystem "Red Hat Enterprise Linux Server for ARM Development
>>> > Preview release 1.5" which has systemd and systemd-logind. Start VM and
>>> > when it starts well type "system_powerdown" on QEMU monitor, the guest
>>> > goes to poweroff. So this way works.
>> Ok, very good.
>>
>>> > Note: we must check the /lib/udev/rules.d/70-power-switch.rules in the
>>> > fs and add one following line in it if it doesn't exist.
>>> >
>>> > SUBSYSTEM=="input", KERNEL=="event*", SUBSYSTEMS=="platform",
>>> > ATTRS{keys}=="116", TAG+="power-switch"
>>> >
>>> > Then when execute journalctl -u systemd-logind in guest, we can see
>>> > something like below:
>>> >
>>> > Jan 01 00:01:02 localhost systemd[1]: Starting Login Service...
>>> > Jan 01 00:01:07 localhost systemd[1]: Started Login Service.
>>> > Jan 01 00:01:07 localhost systemd-logind[927]: Watching system buttons
>>> > on /dev/input/event0 (gpio-keys)
>>> > Jan 01 00:01:07 localhost systemd-logind[927]: New seat seat0.
>>> > Jan 01 00:01:25 localhost systemd-logind[927]: New session c1 of user root.
>>> >
>>> > Visit https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1347776 for
>>> > details.
>> How about Ubuntu or Debian releases that do not use systemd?
>>
>> I guess we should check with a Debian Wheezy or Ubuntu Trusty release.
>> My guess is that it will work fine, but some minor adjustment might
>> be needed.
>
> Will check Debian Wheezy and Ubuntu Trusty release later.
> BTW, I don't have them on hand, where can I get these filesystem for ARM?
>
Try this for Ubuntu trusty:
http://www.cs.columbia.edu/~cdall/linaro-trusty.tar.bz2

(It's a Linaro minimal FS so some things like manpages may be missing
for existing packages, let me know if you run into problems.)

-Christoffer
