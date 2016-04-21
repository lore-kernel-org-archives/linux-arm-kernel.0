From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Apr 2016 01:20:42 +0200
Subject: [PATCH V4] rtc: zynqmp: Update seconds time programming logic
In-Reply-To: <1461167255-33945-1-git-send-email-anuragku@xilinx.com>
References: <1461167255-33945-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20160421232042.GD29844@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/2016 at 21:17:35 +0530, Anurag Kumar Vulisha wrote :
> We programe RTC time using SET_TIME_WRITE register and read the RTC
> current time using CURRENT_TIME register. When we set the time by
> writing into SET_TIME_WRITE Register and immediately try to read the
> rtc time from CURRENT_TIME register, the previous old value is
> returned instead of the new loaded time. This is because RTC takes
> nearly 1 sec to update the  new loaded value into the CURRENT_TIME
> register. This behaviour is expected in our RTC IP.
> 
> This patch updates the driver to read the current time from SET_TIME_WRITE
> register instead of CURRENT_TIME when rtc time is requested within an 1sec
> period after setting the RTC time. Doing so will ensure the correct time
> is given to the user.
> 
> Since there is an delay of 1sec in updating the CURRENT_TIME we are loading
> set time +1sec while programming the SET_TIME_WRITE register, doing this
> will give correct time without any delay when read from CURRENT_TIME.
> 
> This patch updates the above said.
> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> ---
>  Changes in v4:
>    1. Corrected the read time logic
>  Changes in v2:
>    1. Updated the Time programming logic as suggested by Alexandre Belloni
>    2. Changed the commit message
> ---
>  drivers/rtc/rtc-zynqmp.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
