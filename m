From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Sep 2018 14:20:12 +0200
Subject: [GIT PULL] arm64: zynqmp: Xilinx SoC changes for v4.20
In-Reply-To: <CAOesGMjh-Chhncw3cYaCvFpfhtOSz8hprC0xARmVXe8i4mvxHw@mail.gmail.com>
References: <5e9c248d-c19c-1881-f406-d7bfd38ec479@xilinx.com>
 <CAOesGMjh-Chhncw3cYaCvFpfhtOSz8hprC0xARmVXe8i4mvxHw@mail.gmail.com>
Message-ID: <b0df50fb-3889-a3dd-c92f-7877e287f5be@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9.9.2018 03:21, Olof Johansson wrote:
> Hi Michal,
> 
> On Fri, Sep 7, 2018 at 12:57 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> Hi,
>>
>> please pull the following firmware interface to your tree.
>>
>> Thanks,
>> Michal
>>
>>
>> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
>>
>>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/Xilinx/linux-xlnx.git tags/zynqmp-soc-for-v4.20
>>
>> for you to fetch changes up to bca7067d2d4e91f58162b07d73cd94e20437b4f6:
>>
>>   firmware: xilinx: Add debugfs for query data API (2018-09-07 09:44:44
>> +0200)
>>
>> ----------------------------------------------------------------
>> arm64: zynqmp: SoC changes for v4.20
>>
>> - Adding firmware API for SoC with debugfs interface
> 
> This is a bit terse. Jolly has been good at writing cover letters, you
> could have stolen the writeup from there. :)

Isn't it one line which is ending up in summary log?

> 
> I posted two comments on the patches -- one is a nit that can be
> followed up on with an incremental patch.
>
> I'm more worried about the ioctl interface though, and what it opens
> up. Maybe it's been discussed in the time the set has been reviewed, I
> didn't search extensively for the history. If it had been, bringing
> explanations into the patch description would have been nice for new
> readers such as myself. And if it hasn't, well, let's talk about it.

Anyway here is the full spec.
https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf

I don't know all the details that's why please (Jolly) correct me if I
am wrong.
PMUFW which is microblaze running firmware was providing read/write
interface which was checking ranges for accesses. One of that
functionality was for example clock/pin muxing and others. This was done
before any SCMI spec was created because Xilinx needs to deal with
problems how to handle these interfaces.
At that time non secure OS(linux) was owner of all these subsystems.
Over the time it was clear that non secure SW shouldn't have such a big
control over SoC because on this heterogeneous chip it is not covering
all possible use cases.
Based on this new EEMI spec was created to move a lot of functionality
from non secure sw with also improve security of the system. IIRC at
that time SCMI wasn't released that's why we were lacking any standard
interface which we could use directly.

We are also communicating with Arm about SCMI extension but still there
are missing gaps which are not addressed and it will take a lot of time
to have everything there.

I can copy here Jolly's description but these patches are adding
communication layer/interface which provide API for clock, reset, pin
control, secure, serdes, fpga and chip detection to communicate with
PMUFW via ATF by using SMC instructions and then communication interface
setup between A53 and Microblaze.

Arm trusted firmware already contains this interface
https://github.com/ARM-software/arm-trusted-firmware/tree/master/plat/xilinx/zynqmp/pm_service

The v11 contained 11 patches and I have taken first 8 because clock part
is not reviewed by Stephen yet.
Other drivers (fpga, phy/serdes, reset) are sent as RFCs but needs this
firmware interface to have basic stuff up and running before extension.

> 
> Not merging based on the above. Hopefully it's something we can
> straighten out pretty quickly.

Please ask more question if something is unclear and I believe that
Jolly is happy to answer them as quickly as possible.

Thanks,
Michal
