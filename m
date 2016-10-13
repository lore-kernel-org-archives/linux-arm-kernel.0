From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 13 Oct 2016 21:17:48 +0800
Subject: [arm-soc:to-build 4/4]
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4586:10:
 warning: 'is_11d' may be used uninitialized in this function
Message-ID: <201610132130.BqYTDuDA%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git to-build
head:   346c22ea9cb8d0ee331c73529b205414e43a4655
commit: 346c22ea9cb8d0ee331c73529b205414e43a4655 [4/4] Revert "Disable "maybe-uninitialized" warning globally"
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 346c22ea9cb8d0ee331c73529b205414e43a4655
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_cfg80211_start_ap':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4586:10: warning: 'is_11d' may be used uninitialized in this function [-Wmaybe-uninitialized]
       err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_SET_REGULATORY,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              is_11d);
              ~~~~~~~

vim +/is_11d +4586 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c

a44aa400 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Hante Meuleman   2014-12-03  4570  
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4571  			/* RSN IE */
a44aa400 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Hante Meuleman   2014-12-03  4572  			err = brcmf_configure_wpaie(ifp, tmp_ie, true);
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4573  			if (err < 0)
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4574  				goto exit;
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4575  		}
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4576  	} else {
d96b801f drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2012-12-05  4577  		brcmf_dbg(TRACE, "No WPA(2) IEs found\n");
1f170110 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-06  4578  		brcmf_configure_opensecurity(ifp);
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4579  	}
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4580  
a0f07959 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2013-02-08  4581  	brcmf_config_ap_mgmt_ie(ifp->vif, &settings->beacon);
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4582  
8707e08d drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Rafa? Mi?ecki    2016-05-27  4583  	/* Parameters shared by all radio interfaces */
a44aa400 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Hante Meuleman   2014-12-03  4584  	if (!mbss) {
b3589dfe drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c Hante Meuleman   2016-09-19  4585  		if ((supports_11d) && (is_11d != ifp->vif->is_11d)) {
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21 @4586  			err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_SET_REGULATORY,
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4587  						    is_11d);
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4588  			if (err < 0) {
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4589  				brcmf_err("Regulatory Set Error, %d\n", err);
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4590  				goto exit;
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4591  			}
98027769 drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c          Arend van Spriel 2014-12-21  4592  		}
1a873342 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Hante Meuleman   2012-09-27  4593  		if (settings->beacon_interval) {
ac24be6f drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c       Arend van Spriel 2012-10-22  4594  			err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_SET_BCNPRD,

:::::: The code at line 4586 was first introduced by commit
:::::: 98027769828f772c7ce69b6e58d37b78ebe8ab28 brcmfmac: enable 802.11d support in firmware

:::::: TO: Arend van Spriel <arend@broadcom.com>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50804 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161013/18fc4945/attachment-0001.gz>
