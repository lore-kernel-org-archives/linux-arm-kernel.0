From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 10 May 2016 10:18:45 +1000
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20160510101845.380ff1b2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/linux/soc/qcom/smd.h

between commit:

  b853cb9628bf ("soc: qcom: smd: Make callback pass channel reference")

from the arm-soc tree and commit:

  43315f31adc2 ("soc: qcom: smd: Introduce compile stubs")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

I wasn't sure if the new functions introduced by b853cb9628bf also
needed compile stubs.
-- 
Cheers,
Stephen Rothwell

diff --cc include/linux/soc/qcom/smd.h
index cb2f81559bc0,46a984f5e3a3..000000000000
--- a/include/linux/soc/qcom/smd.h
+++ b/include/linux/soc/qcom/smd.h
@@@ -44,23 -42,42 +44,49 @@@ struct qcom_smd_driver 
  
  	int (*probe)(struct qcom_smd_device *dev);
  	void (*remove)(struct qcom_smd_device *dev);
 -	int (*callback)(struct qcom_smd_device *, const void *, size_t);
 +	qcom_smd_cb_t callback;
  };
  
+ #if IS_ENABLED(CONFIG_QCOM_SMD)
+ 
  int qcom_smd_driver_register(struct qcom_smd_driver *drv);
  void qcom_smd_driver_unregister(struct qcom_smd_driver *drv);
  
 +void *qcom_smd_get_drvdata(struct qcom_smd_channel *channel);
 +void qcom_smd_set_drvdata(struct qcom_smd_channel *channel, void *data);
 +
+ int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len);
+ 
+ #else
+ 
+ static inline int qcom_smd_driver_register(struct qcom_smd_driver *drv)
+ {
+ 	return -ENXIO;
+ }
+ 
+ static inline void qcom_smd_driver_unregister(struct qcom_smd_driver *drv)
+ {
+ 	/* This shouldn't be possible */
+ 	WARN_ON(1);
+ }
+ 
+ static inline int qcom_smd_send(struct qcom_smd_channel *channel,
+ 				const void *data, int len)
+ {
+ 	/* This shouldn't be possible */
+ 	WARN_ON(1);
+ 	return -ENXIO;
+ }
+ 
+ #endif
+ 
  #define module_qcom_smd_driver(__smd_driver) \
  	module_driver(__smd_driver, qcom_smd_driver_register, \
  		      qcom_smd_driver_unregister)
  
- int qcom_smd_send(struct qcom_smd_channel *channel, const void *data, int len);
  
 +struct qcom_smd_channel *qcom_smd_open_channel(struct qcom_smd_channel *channel,
 +					       const char *name,
 +					       qcom_smd_cb_t cb);
 +
  #endif
