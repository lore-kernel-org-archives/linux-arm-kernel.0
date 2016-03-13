From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Mar 2016 17:08:49 -0800
Subject: [PATCH] bus: imx-weim: Take the 'status' property value into
 account
In-Reply-To: <20160229033649.GS22051@tiger>
References: <1456142513-12876-1-git-send-email-festevam@gmail.com>
 <20160229033649.GS22051@tiger>
Message-ID: <20160313010849.GI17502@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 11:36:49AM +0800, Shawn Guo wrote:
> On Mon, Feb 22, 2016 at 09:01:53AM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > Currently we have an incorrect behaviour when multiple devices
> > are present under the weim node. For example:
> > 
> > &weim {
> > 	...
> > 	status = "okay";
> > 	
> > 	sram at 0,0 {
> > 		...
> >         	status = "okay";
> > 	};
> > 
> > 	mram at 0,0 {
> > 		...
> >         	status = "disabled";
> >     	};
> > };
> > 
> > In this case only the 'sram' device should be probed and not 'mram'.
> > 
> > However what happens currently is that the status variable is ignored,
> > causing the 'sram' device to be disabled and 'mram' to be enabled.  
> > 
> > Change the weim_parse_dt() function to use
> > for_each_available_child_of_node()so that the devices marked with
> > 'status = disabled' are not probed.
> > 
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
> > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 
> Arnd, Olof,
> 
> I do not have any other 'driver' patches queued, so please help directly
> apply this one.  Considering this fixes a real problem, it would be good
> if we can merge this through -rc.  But we understand that it's -rc6 now,
> and this doesn't fix a regression or so-critical issue, so it should be
> fine to queue the patch for the next release as well.

Sorry for the high latency here, I had missed this patch and noticed now when
I did a sweep. I've merged it into next/drivers for 4.6.


-Olof
