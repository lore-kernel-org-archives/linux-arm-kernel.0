From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Oct 2018 11:25:04 +0000
Subject: [PATCH] arm64/numa: Add more vetting in numa_set_distance()
In-Reply-To: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
References: <1540562267-101152-1-git-send-email-john.garry@huawei.com>
Message-ID: <20181029112504.GF14127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Fri, Oct 26, 2018 at 09:57:47PM +0800, John Garry wrote:
> Currently it is acceptable to set the distance between 2 separate nodes to
> LOCAL_DISTANCE.
> 
> Reject this as it is invalid.
> 
> This change avoids a crash reported in [1].
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg683304.html
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index 146c04c..6092e3d 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -335,7 +335,8 @@ void __init numa_set_distance(int from, int to, int distance)
>  	}
>  
>  	if ((u8)distance != distance ||
> -	    (from == to && distance != LOCAL_DISTANCE)) {
> +	    (from == to && distance != LOCAL_DISTANCE) ||
> +	    (from != to && distance == LOCAL_DISTANCE)) {

The current code here is more-or-less lifted from the x86 implementation
of numa_set_distance(). I think we should either factor out the sanity check
into a core helper or make the core code robust to these funny configurations.

Will
