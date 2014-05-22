From: agross@codeaurora.org (Andy Gross)
Date: Thu, 22 May 2014 10:32:14 -0500
Subject: [PATCH] dmaengine: qcom_bam_dma: Add descriptor flag APIs
In-Reply-To: <537E1749.1030505@linaro.org>
References: <1397772242-4048-1-git-send-email-agross@codeaurora.org>
 <20140502162841.GZ32284@intel.com>
 <20140502180827.GA9476@qualcomm.com>
 <20140515173206.GA16858@qualcomm.com>
 <20140522061049.GW21128@intel.com>
 <20140522150906.GA22327@qualcomm.com> <537E1749.1030505@linaro.org>
Message-ID: <20140522153214.GB22327@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 04:27:05PM +0100, Srinivas Kandagatla wrote:

<snip>

> >
> >The EOT is not used for every transaction.  It is part of a handshaking
> >protocol with the attached peripheral, much like the NWD (notify when done).  As
> >near as I can tell today, no peripheral depends on the EOB, so we could drop it
> >for now until it is needed and cross this bridge when we need to.
> 
> As EOT behaviour is totally dependent on the attached peripheral(or
> channel), Can't we make this specific to channel by passing
> additional flags in the DT dma channel descriptors? This will be
> better abstraction for drivers as well.

Even for channels where you want to use EOT, you don't use it for every
transaction.  So a global channel flag isn't going to work.  This is the same
for NWD.  It is a per descriptor choice.

> 
> I know that EOT flag is part of descriptor but still some channels
> *must* have EOT to run there state-machine correctly. So making it
> optional for those channels might be wrong.
> 
> Are there any use cases for particular *channel* where EOT
> requirement changes dynamically?

I2C is one example.  You place EOT on the last transaction that makes up a
write/read transaction.  You may have multiple descriptors to send data, but the
last one has EOT.  And for read transactions, you place NWD on the last read
transaction.

<snip>

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
