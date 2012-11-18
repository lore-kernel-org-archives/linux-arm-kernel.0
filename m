From: Larry.Finger@lwfinger.net (Larry Finger)
Date: Sun, 18 Nov 2012 14:18:37 -0600
Subject: [Patch v1 1/1] RTL8712 alignment bug in 3.6.5 on ARM
In-Reply-To: <20121118181140.GC14643@lunn.ch>
References: <CAMW5UfYUi-Zz2r5K9GeVzShSub2rDJVuoWR56+89+ytaqo_uxQ@mail.gmail.com>
 <20121118181140.GC14643@lunn.ch>
Message-ID: <50A9429D.1010908@lwfinger.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2012 12:11 PM, Andrew Lunn wrote:
>
> Just to clarify the issue here:
>
> union pn48 {
>          u64 val;
> #if defined(__BIG_ENDIAN)
>          struct {
>                  u8 TSC7;
>                  u8 TSC6;
>
> Any instance of pn48 needs to be 64 bit aligned when the val member of
> the union is used. The structure sta_info contains two such pn48s, so
> the code allocating the pool of these needs to ensure it allocated
> them 64 bit aligned, not 32bit aligned as it currently is.

Andrew,

For my education, would the following patch ensure 64-bit alignment for the pn48 
instances, or is more needed?

Index: staging/drivers/staging/rtl8712/rtl871x_security.h
===================================================================
--- staging.orig/drivers/staging/rtl8712/rtl871x_security.h
+++ staging/drivers/staging/rtl8712/rtl871x_security.h
@@ -89,6 +89,8 @@ struct RT_PMKID_LIST {
  };

  struct security_priv {
+       union pn48 Grptxpn;             /* PN48 used for Grp Key xmit. */
+       union pn48 Grprxpn;             /* PN48 used for Grp Key recv. */
         u32 AuthAlgrthm;                /* 802.11 auth, could be open, shared,
                                          * 8021x and authswitch */
         u32 PrivacyAlgrthm;             /* This specify the privacy for shared
@@ -104,8 +106,6 @@ struct security_priv {
                                          * inx0 and inx1 */
         union Keytype   XGrptxmickey[2];
         union Keytype   XGrprxmickey[2];
-       union pn48 Grptxpn;             /* PN48 used for Grp Key xmit. */
-       union pn48 Grprxpn;             /* PN48 used for Grp Key recv. */
         u8 wps_hw_pbc_pressed;/*for hw pbc pressed*/
         u8 wps_phase;/*for wps*/
         u8 wps_ie[MAX_WPA_IE_LEN<<2];

Thanks,

Larry
