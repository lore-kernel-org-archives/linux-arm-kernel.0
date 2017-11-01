From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 1 Nov 2017 09:18:49 +0000
Subject: [Patch v10] QE: remove PPCisms for QE
In-Reply-To: <20171101020133.27966-1-qiang.zhao@nxp.com>
References: <20171101020133.27966-1-qiang.zhao@nxp.com>
Message-ID: <b9a491c9-c7f9-3062-8c85-468c1a94ba0d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhao,

I just noticed a small nit.

On 01/11/17 02:01, Zhao Qiang wrote:
> QE was supported on PowerPC, and dependent on PPC,
> Now it is supported on other platforms. so remove PPCisms.
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- na
> Changes for v3:
> 	- add NO_IRQ
> Changes for v4:
> 	- modify spin_event_timeout to opencoded timeout loop
> 	- remove NO_IRQ
> 	- modify virq_to_hw to opencoed code
> Changes for v5:
> 	- modify commit msg
> 	- modify depends of QUICC_ENGINE
> 	- add kerneldoc header for qe_issue_cmd
> Changes for v6:
> 	- add dependency on FSL_SOC and PPC32 for drivers
> 	  depending on QUICC_ENGING but not available on ARM
> Changes for v7:
> 	- split qeic part to another patch
> 	- rebase
> Changes for v8:
> 	- include <asm/cpm.h> in ucc_uart
> Changes for v9:
> 	- fix cast warning
> Changes for v10:
> 	- rebase
> 
>   drivers/net/ethernet/freescale/Kconfig | 11 ++---
>   drivers/soc/fsl/qe/Kconfig             |  2 +-
>   drivers/soc/fsl/qe/qe.c                | 82 +++++++++++++++++++++-------------
>   drivers/soc/fsl/qe/qe_io.c             | 42 ++++++++---------
>   drivers/soc/fsl/qe/qe_tdm.c            |  8 ++--
>   drivers/soc/fsl/qe/ucc.c               | 10 ++---
>   drivers/soc/fsl/qe/ucc_fast.c          | 74 +++++++++++++++---------------
>   drivers/tty/serial/Kconfig             |  2 +-
>   drivers/tty/serial/ucc_uart.c          |  1 +
>   drivers/usb/gadget/udc/Kconfig         |  2 +-
>   drivers/usb/host/Kconfig               |  2 +-
>   include/soc/fsl/qe/qe.h                |  1 -
>   12 files changed, 126 insertions(+), 111 deletions(-)
> 

[...]

> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 2ef6fc6487c1..1d695870ea9e 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c

[...]

> @@ -132,20 +142,26 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
>   				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
>   		}
>   
> -		out_be32(&qe_immr->cp.cecdr, cmd_input);
> -		out_be32(&qe_immr->cp.cecr,
> -			 (cmd | QE_CR_FLG | ((u32) device << dev_shift) | (u32)
> -			  mcn_protocol << mcn_shift));
> +		iowrite32be(cmd_input, &qe_immr->cp.cecdr);
> +		iowrite32be((cmd | QE_CR_FLG | ((u32)device << dev_shift) |
> +			    (u32)mcn_protocol << mcn_shift), &qe_immr->cp.cecr);
>   	}
>   
>   	/* wait for the QE_CR_FLG to clear */
> -	ret = spin_event_timeout((in_be32(&qe_immr->cp.cecr) & QE_CR_FLG) == 0,
> -			   100, 0);
> +	ret = -EIO;
> +	for (i = 0; i < 100; i++) {
> +		if ((ioread32be(&qe_immr->cp.cecr) & QE_CR_FLG) == 0) {
> +			ret = 0;
> +			break;
> +		}
> +		udelay(1);
> +	}
> +
>   	/* On timeout (e.g. failure), the expression will be false (ret == 0),
>   	   otherwise it will be true (ret == 1). */

nit:
The comment here is no longer valid, on timeout ret == -EIO and on 
success 0. It should probably be removed to avoid confusion.

Cheers,

-- 
Julien Thierry
