From: itaru.kitayama@riken.jp (Itaru Kitayama)
Date: Fri, 15 Sep 2017 08:17:40 +0900
Subject: ThunderX BMC initialization failure
In-Reply-To: <CALdTtnst3PFaTo-ku85hj1QTp4kN4B1eOF3bYsmQrHWrpNGPTg@mail.gmail.com>
References: <087dcefa-1402-2d9f-da8d-18782df9eea3@riken.jp>
 <CALdTtnst3PFaTo-ku85hj1QTp4kN4B1eOF3bYsmQrHWrpNGPTg@mail.gmail.com>
Message-ID: <04d91939-a4a5-cc39-12d2-b99ef8053592@riken.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dann,

Thanks for the information. Will try to upgrade the kernel when I have 
an opportunity.

$ sudo dmidecode |grep IPMI
IPMI Device Information

Does the above something I should expect to see?

On 9/15/17 8:10 AM, dann frazier wrote:
> On Tue, Sep 12, 2017 at 2:55 AM, Itaru Kitayama <itaru.kitayama@riken.jp> wrote:
>> Hi,
>>
>> We're seeing below on our ThunderX
>>
>> $ sudo systemctl start ipmi
>> Job for ipmi.service failed because the control process exited with error
>> code. See "systemctl status ipmi.service" and "journalctl -xe" for details.
>> $ sudo journalctl -xe
>> ...
>> -- Unit ipmi.service has begun starting up.
>> Sep 12 15:54:52 satsuma kernel: ipmi message handler version 39.2
>> Sep 12 15:54:53 satsuma kernel: IPMI System Interface driver.
>> Sep 12 15:54:53 satsuma kernel: ipmi_si: probing via SMBIOS
>> Sep 12 15:54:53 satsuma kernel: ipmi_si: Unable to find any System
>> Interface(s)
>> Sep 12 15:54:53 satsuma openipmi-helper[2800]: Startup failed.
>> Sep 12 15:54:53 satsuma systemd[1]: ipmi.service: main process exited,
>> code=exited, status=1/FAILURE
>> Sep 12 15:54:53 satsuma systemd[1]: Failed to start IPMI Driver.
>> -- Subject: Unit ipmi.service has failed
>> ...
>>
>> Is it caused by the IPMI driver that comes with CentOS 7 or the BIOS?
> Itaru,
>
> There could be multiple things going on here. For one, I don't believe
> openipmi's upstream initscript knows about the ipmi_ssif driver yet.
> This issue may also impact CentOS (and probably needs fixing in
> upstream openipmi):
>    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=875537
>
> And your kernel needs to be new enough and have the right drivers
> enabled to support it.
> v4.12 should be new enough. Tests for that are described here:
>   https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1688132
>
> Finally, your BIOS does need to have SMBIOS tables that describe the
> interface. Make sure this returns something:
> $ sudo dmidecode | grep IPMI
>
>    -dann
