From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 20:42:32 +0900
Subject: [PATCH 09/10] S3C64XX I2S: Set parent links for clock audio-bus.
In-Reply-To: <20090915111204.GJ22878@rakim.wolfsonmicro.main>
References: <1253008961-10698-1-git-send-email-jassi.brar@samsung.com>
	<20090915111204.GJ22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150442m5aaf826fy73a9c48bd2fabbf2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 8:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 07:02:41PM +0900, Jassi wrote:
>> Explicitly route audio-bus from FOUTepll via MOUTepll.
>
>> Signed-Off-by: Jassi <jassi.brar@samsung.com>
>
> Why do this in the audio driver rather than doing it in the arch/arm
> code? ?It seems bad form for the audio driver to be looking at clock
> configuration outside its domain.
I understand that.
Even without this patch it sources FOUTepll by default.
This is not meant to be forever.  I patched it because
I didn't want to get stuck making platform perfect to push the idea.

>> + ? ? cm = clk_get(NULL, "mout_epll");
>> + ? ? if (IS_ERR(cm)) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to get mout_epll\n");
>> + ? ? ? ? ? ? ret = PTR_ERR(cm);
>> + ? ? ? ? ? ? goto mout_err;
>> + ? ? }
>> + ? ? clk_set_parent(i2s->iis_cclk, cm);
>> + ? ? cf = clk_get(NULL, "fout_epll");
>> + ? ? if (IS_ERR(cf)) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to get fout_epll\n");
>> + ? ? ? ? ? ? ret = PTR_ERR(cf);
>> + ? ? ? ? ? ? goto fout_err;
>> + ? ? }
>> + ? ? clk_set_parent(cm, cf);
>
> The mout/fout connection in particular isn't audio local, there's way
> more EPLL users than just the audio.
Ofcourse, but i think those drivers and requirements are far off that
may need EPLL.
EPLL is a shared but unused resource. Using EPLL gives far more accurate clocks
and we shudn't keep hands off just because there is no arbiter.
If not here, i favor controlling it from machine specific code.
