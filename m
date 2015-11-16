From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 16:58:21 +0100
Subject: [PATCH V5 2/3] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <1447620855-4974-3-git-send-email-okaya@codeaurora.org>
References: <1447620855-4974-1-git-send-email-okaya@codeaurora.org>
 <1447620855-4974-3-git-send-email-okaya@codeaurora.org>
Message-ID: <6159200.u9U0p8aIkU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 November 2015 15:54:13 Sinan Kaya wrote:
> The Qualcomm Technologies HIDMA device has been designed
> to support virtualization technology. The driver has been
> divided into two to follow the hardware design.
> 
> 1. HIDMA Management driver
> 2. HIDMA Channel driver
> 
> Each HIDMA HW consists of multiple channels. These channels
> share some set of common parameters. These parameters are
> initialized by the management driver during power up.
> Same management driver is used for monitoring the execution
> of the channels. Management driver can change the performance
> behavior dynamically such as bandwidth allocation and
> prioritization.
> 
> The management driver is executed in hypervisor context and
> is the main management entity for all channels provided by
> the device.

Sorry for asking this question so late, but can you explain what the
point is behind this? It seems counterintuitive to me to have a
DMA engine that is meant for speeding up memory-to-memory transfers
when you run it in a virtual machine where you either need to go
through a virtual IOMMU to set up page table entries, as that will
likely cause more performance overhead than you could possibly
gain, or you assume that all the guest memory is pinned, which
in turn destroys a lot of the assumptions that we are making
in KVM to have useful VM guests.

Where am I going wrong here?

>  .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++++
>  drivers/dma/qcom/Kconfig                           |  10 +
>  drivers/dma/qcom/Makefile                          |   1 +
>  drivers/dma/qcom/hidma_mgmt.c                      | 306 +++++++++++++++++++++
>  drivers/dma/qcom/hidma_mgmt.h                      |  38 +++
>  drivers/dma/qcom/hidma_mgmt_sys.c                  | 231 ++++++++++++++++

Each sysfs file API you add needs a documentation in Documentation/ABI/.

	Arnd
