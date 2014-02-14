From: acourbot@nvidia.com (Alexandre Courbot)
Date: Fri, 14 Feb 2014 14:16:36 +0900
Subject: [PATCH v2 4/6] ARM: firmware: add prepare_idle() operation
In-Reply-To: <52FCA5FC.80504@samsung.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
 <1391747706-1847-5-git-send-email-acourbot@nvidia.com>
 <52FCA5FC.80504@samsung.com>
Message-ID: <52FDA6B4.6070404@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 08:01 PM, Tomasz Figa wrote:
> Hi Alexandre,
>
> On 07.02.2014 05:35, Alexandre Courbot wrote:
>> Some firmwares do not put the CPU into idle mode themselves, but still
>> need to be informed that the CPU is about to enter idle mode before this
>> happens. Add a prepare_idle() operation to the firmware_ops structure to
>> handle such cases.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>    arch/arm/include/asm/firmware.h | 4 ++++
>>    1 file changed, 4 insertions(+)
>
> I wonder if .do_idle() couldn't simply return an appropriate error code
> to let the upper layer know that it should proceed with normal CPU idle
> activation, while still letting the firmware know that the CPU is going
> to idle.

In our particular case I agree it would be enough to use do_idle() to 
let the firmware know about the operation and have it return -ENOSYS so 
the kernel actually performs it. I'm afraid this might not fulfill all 
needs though (e.g. one can imagine a firmware where the OS needs to take 
action between the notification and the actual shutdown), and as Stephen 
pointed out that would make the name of the function ambiguous at best. 
I'd rather keep it the current way for clarity.
