From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 18 Feb 2014 12:22:05 -0800
Subject: [PATCH] dt: platform driver: Fill the resources before probe and
 defer if needed
In-Reply-To: <1392285429-9325-1-git-send-email-jjhiblot@traphandler.com>
References: <1392285429-9325-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140218202205.GA13835@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 10:57:09AM +0100, Jean-Jacques Hiblot wrote:
> The goal of this patch is to allow drivers to be probed even if at the time of
> the DT parsing some of their ressources are not available yet.
> 
> In the current situation, the resource of a platform device are filled from the
> DT at the time the device is created (of_device_alloc()). The drawbackof this
> is that a device sitting close to the top of the DT (ahb for example) but
> depending on ressources that are initialized later (IRQ domain dynamically
> created for example)  will fail to probe because the ressources don't exist
> at this time.
> 
> This patch fills the resource structure only before the device is probed and
> will defer the probe if the resource are not available yet.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/base/platform.c     |  6 ++++
>  drivers/of/platform.c       | 71 +++++++++++++++++++++++++++++----------------
>  include/linux/of_platform.h | 10 +++++++
>  3 files changed, 62 insertions(+), 25 deletions(-)

I need some others to ack this before I can take it...
