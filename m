From: eric.auger@redhat.com (Auger Eric)
Date: Mon, 8 May 2017 18:03:30 +0200
Subject: [PATCH 1/8] KVM: arm/arm64: Clarification and relaxation to ITS
 save/restore ABI
In-Reply-To: <20170508115454.5075-2-cdall@linaro.org>
References: <20170508115454.5075-1-cdall@linaro.org>
 <20170508115454.5075-2-cdall@linaro.org>
Message-ID: <14b88127-32da-ebb3-684d-8f53b00e565f@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 08/05/2017 13:54, Christoffer Dall wrote:
> Clarify what is meant by the save/restore ABI only supporting virtual
> physical interrupts.
> 
> Relax the requirement of the order that the collection entries are
> written in and be clear that there is no particular ordering enforced.
> 
> Some cosmetic changes in the capitalization of ID names to align with
> the GICv3 manual and remove the empty line in the bottom of the patch.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  Documentation/virtual/kvm/devices/arm-vgic-its.txt | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/devices/arm-vgic-its.txt b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> index ba132e9..d405242 100644
> --- a/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> +++ b/Documentation/virtual/kvm/devices/arm-vgic-its.txt
> @@ -110,12 +110,14 @@ Then vcpus can be started.
>   ITS Table ABI REV0:
>   -------------------
>  
> - Revision 0 of the ABI only supports physical LPIs.
> + Revision 0 of the ABI only supports the features of a virtual GICv3, and does
> + not support a virtual GICv4 with support for direct injection of virtual
> + interrupts for nested hypervisors.
>  
> - The device table and ITT are indexed by the deviceid and eventid,
> - respectively. The collection table is not indexed by collectionid:
> - CTEs are written in the table in the order of collection creation. All
> - entries are 8 bytes.
> + The device table and ITT are indexed by the DeviceID and EventID,
> + respectively. The collection table is not indexed by CollectionID, and the
> + entries in the collection are listed in no particular order.
> + All entries are 8 bytes.
>  
>   Device Table Entry (DTE):
>  
> @@ -126,10 +128,10 @@ Then vcpus can be started.
>   - V indicates whether the entry is valid. If not, other fields
>     are not meaningful.
>   - next: equals to 0 if this entry is the last one; otherwise it
> -   corresponds to the deviceid offset to the next DTE, capped by
> +   corresponds to the DeviceID offset to the next DTE, capped by
>     2^14 -1.
>   - ITT_addr matches bits [51:8] of the ITT address (256 Byte aligned).
> - - Size specifies the supported number of bits for the eventid,
> + - Size specifies the supported number of bits for the EventID,
>     minus one
>  
>   Collection Table Entry (CTE):
> @@ -151,8 +153,7 @@ Then vcpus can be started.
>  
>   where:
>   - next: equals to 0 if this entry is the last one; otherwise it corresponds
> -   to the eventid offset to the next ITE capped by 2^16 -1.
> +   to the EventID offset to the next ITE capped by 2^16 -1.
>   - pINTID is the physical LPI ID; if zero, it means the entry is not valid
>     and other fields are not meaningful.
>   - ICID is the collection ID
> -
> 
