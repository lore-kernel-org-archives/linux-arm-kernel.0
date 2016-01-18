From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 18 Jan 2016 12:38:55 +0000
Subject: [Xen-devel] [PATCH v2 08/16] xen/hvm/params: Add a new delivery
 type for event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <1452840929-19612-9-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-9-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <alpine.DEB.2.02.1601181205110.16178@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Jan 2016, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> Add a new delivery type:
> val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
> To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
> bit 1 stands the interrupt polarity is active low(1) or high(0).
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  include/xen/interface/hvm/params.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
> index a6c7991..550688a 100644
> --- a/include/xen/interface/hvm/params.h
> +++ b/include/xen/interface/hvm/params.h
> @@ -34,6 +34,11 @@
>   *                  Domain = val[47:32], Bus  = val[31:16],
>   *                  DevFn  = val[15: 8], IntX = val[ 1: 0]
>   * val[63:56] == 2: val[7:0] is a vector number.
> + * val[63:56] == 3: val[15:8] is flag of event-channel interrupt:
> + *                      bit 0: interrupt is edge(1) or level(0) triggered
> + *                      bit 1: interrupt is active low(1) or high(0)
> + *                  val[7:0] is PPI number used by event-channel.
> + *                  This is only used by ARM/ARM64.
>   * If val == 0 then CPU0 event-channel notifications are not delivered.
>   */
>  #define HVM_PARAM_CALLBACK_IRQ 0

Andrew, I think that this patch is correct. Looking back at your
previous comment (http://marc.info/?l=devicetree&m=144804014214262&w=2),
is it possible that you were confused by enum callback_via_type, which
is internal to Xen and offset'ed by 1 compared to the described values
in xen/include/public/hvm/params.h?

If not, and indeed somebody introduced one more field but failed to
document it, then I suggest she sends a patch to fix the issue as soon
as possible.
