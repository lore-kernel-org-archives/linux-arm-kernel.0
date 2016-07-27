From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 28 Jul 2016 00:54:07 +0800
Subject: [xlnx:master 2556/2625] drivers/gpu/drm/xylon/xylon_encoder.c:171:8:
 error: too few arguments to function 'drm_encoder_init'
Message-ID: <201607280059.ent4RfiF%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   4dcc2058b8620d77b8be9940626b339d848c0dfc
commit: ef0a1fd5ad14a1373f9c483a9426e277ca213cab [2556/2625] Merge tag 'v4.5' into master
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        git checkout ef0a1fd5ad14a1373f9c483a9426e277ca213cab
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/xylon/xylon_encoder.c: In function 'xylon_drm_encoder_dpms':
>> drivers/gpu/drm/xylon/xylon_encoder.c:49:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     encoder_sfuncs = encoder_slave->slave_funcs;
                    ^
   drivers/gpu/drm/xylon/xylon_encoder.c: In function 'xylon_drm_encoder_mode_fixup':
   drivers/gpu/drm/xylon/xylon_encoder.c:70:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     encoder_sfuncs = encoder_slave->slave_funcs;
                    ^
   drivers/gpu/drm/xylon/xylon_encoder.c: In function 'xylon_drm_encoder_mode_set':
   drivers/gpu/drm/xylon/xylon_encoder.c:108:17: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     encoder_sfuncs = encoder_slave->slave_funcs;
                    ^
   drivers/gpu/drm/xylon/xylon_encoder.c: In function 'xylon_drm_encoder_create':
>> drivers/gpu/drm/xylon/xylon_encoder.c:171:8: error: too few arguments to function 'drm_encoder_init'
     ret = drm_encoder_init(dev, &encoder->slave.base,
           ^~~~~~~~~~~~~~~~
   In file included from include/drm/drmP.h:68:0,
                    from drivers/gpu/drm/xylon/xylon_encoder.c:20:
   include/drm/drm_crtc.h:2230:5: note: declared here
    int drm_encoder_init(struct drm_device *dev,
        ^~~~~~~~~~~~~~~~
--
   drivers/gpu/drm/xylon/xylon_connector.c: In function 'xylon_drm_connector_get_modes':
>> drivers/gpu/drm/xylon/xylon_connector.c:44:3: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      encoder_slave->slave_funcs;
      ^~~~~~~~~~~~~
   drivers/gpu/drm/xylon/xylon_connector.c: In function 'xylon_drm_connector_mode_valid':
   drivers/gpu/drm/xylon/xylon_connector.c:61:3: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      encoder_slave->slave_funcs;
      ^~~~~~~~~~~~~
   drivers/gpu/drm/xylon/xylon_connector.c: In function 'xylon_drm_connector_detect':
   drivers/gpu/drm/xylon/xylon_connector.c:94:3: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      encoder_slave->slave_funcs;
      ^~~~~~~~~~~~~
--
>> drivers/gpu/drm/xylon/xylon_fb.c:132:15: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
     .fb_create = xylon_drm_fb_create,
                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/xylon/xylon_fb.c:132:15: note: (near initialization for 'xylon_drm_mode_config_funcs.fb_create')

vim +/drm_encoder_init +171 drivers/gpu/drm/xylon/xylon_encoder.c

d743a182d Davor Joja 2014-03-24   43  {
d743a182d Davor Joja 2014-03-24   44  	struct xylon_drm_encoder *encoder;
d743a182d Davor Joja 2014-03-24   45  	struct drm_encoder_slave *encoder_slave;
d743a182d Davor Joja 2014-03-24   46  	struct drm_encoder_slave_funcs *encoder_sfuncs;
d743a182d Davor Joja 2014-03-24   47  
d743a182d Davor Joja 2014-03-24   48  	encoder_slave = to_encoder_slave(base_encoder);
d743a182d Davor Joja 2014-03-24  @49  	encoder_sfuncs = encoder_slave->slave_funcs;
d743a182d Davor Joja 2014-03-24   50  	encoder = to_xylon_encoder(encoder_slave);
d743a182d Davor Joja 2014-03-24   51  
d743a182d Davor Joja 2014-03-24   52  	if (encoder->dpms == dpms)
d743a182d Davor Joja 2014-03-24   53  		return;
d743a182d Davor Joja 2014-03-24   54  
d743a182d Davor Joja 2014-03-24   55  	encoder->dpms = dpms;
d743a182d Davor Joja 2014-03-24   56  	if (encoder_sfuncs->dpms)
d743a182d Davor Joja 2014-03-24   57  		encoder_sfuncs->dpms(base_encoder, dpms);
d743a182d Davor Joja 2014-03-24   58  }
d743a182d Davor Joja 2014-03-24   59  
d743a182d Davor Joja 2014-03-24   60  static bool
d743a182d Davor Joja 2014-03-24   61  xylon_drm_encoder_mode_fixup(struct drm_encoder *base_encoder,
d743a182d Davor Joja 2014-03-24   62  			     const struct drm_display_mode *mode,
d743a182d Davor Joja 2014-03-24   63  			     struct drm_display_mode *adjusted_mode)
d743a182d Davor Joja 2014-03-24   64  {
d743a182d Davor Joja 2014-03-24   65  	struct drm_encoder_slave *encoder_slave;
d743a182d Davor Joja 2014-03-24   66  	struct drm_encoder_slave_funcs *encoder_sfuncs;
d743a182d Davor Joja 2014-03-24   67  	bool ret = true;
d743a182d Davor Joja 2014-03-24   68  
d743a182d Davor Joja 2014-03-24   69  	encoder_slave = to_encoder_slave(base_encoder);
d743a182d Davor Joja 2014-03-24  @70  	encoder_sfuncs = encoder_slave->slave_funcs;
d743a182d Davor Joja 2014-03-24   71  	if (encoder_sfuncs->mode_fixup)
d743a182d Davor Joja 2014-03-24   72  		ret = encoder_sfuncs->mode_fixup(base_encoder, mode,
d743a182d Davor Joja 2014-03-24   73  						 adjusted_mode);
d743a182d Davor Joja 2014-03-24   74  
d743a182d Davor Joja 2014-03-24   75  	return ret;
d743a182d Davor Joja 2014-03-24   76  }
d743a182d Davor Joja 2014-03-24   77  
d743a182d Davor Joja 2014-03-24   78  static void xylon_drm_encoder_mode_set(struct drm_encoder *base_encoder,
d743a182d Davor Joja 2014-03-24   79  				       struct drm_display_mode *mode,
d743a182d Davor Joja 2014-03-24   80  				       struct drm_display_mode *adjusted_mode)
d743a182d Davor Joja 2014-03-24   81  {
d743a182d Davor Joja 2014-03-24   82  	struct xylon_drm_encoder *encoder;
d743a182d Davor Joja 2014-03-24   83  	struct drm_device *dev = base_encoder->dev;
d743a182d Davor Joja 2014-03-24   84  	struct drm_encoder_slave *encoder_slave;
d743a182d Davor Joja 2014-03-24   85  	struct drm_encoder_slave_funcs *encoder_sfuncs;
d743a182d Davor Joja 2014-03-24   86  	struct drm_connector *iter;
d743a182d Davor Joja 2014-03-24   87  	struct drm_connector *connector = NULL;
d743a182d Davor Joja 2014-03-24   88  
d743a182d Davor Joja 2014-03-24   89  	DRM_DEBUG("h: %d, v: %d\n",
d743a182d Davor Joja 2014-03-24   90  		  adjusted_mode->hdisplay, adjusted_mode->vdisplay);
d743a182d Davor Joja 2014-03-24   91  	DRM_DEBUG("refresh: %d, pclock: %d khz\n",
d743a182d Davor Joja 2014-03-24   92  		  adjusted_mode->vrefresh, adjusted_mode->clock);
d743a182d Davor Joja 2014-03-24   93  
d743a182d Davor Joja 2014-03-24   94  	encoder_slave = to_encoder_slave(base_encoder);
d743a182d Davor Joja 2014-03-24   95  	encoder = to_xylon_encoder(encoder_slave);
d743a182d Davor Joja 2014-03-24   96  
d743a182d Davor Joja 2014-03-24   97  	list_for_each_entry(iter, &dev->mode_config.connector_list, head) {
d743a182d Davor Joja 2014-03-24   98  		if (iter->encoder == base_encoder) {
d743a182d Davor Joja 2014-03-24   99  			connector = iter;
d743a182d Davor Joja 2014-03-24  100  			break;
d743a182d Davor Joja 2014-03-24  101  		}
d743a182d Davor Joja 2014-03-24  102  	}
d743a182d Davor Joja 2014-03-24  103  	if (!connector) {
d743a182d Davor Joja 2014-03-24  104  		DRM_ERROR("failed find a connector\n");
d743a182d Davor Joja 2014-03-24  105  		return;
d743a182d Davor Joja 2014-03-24  106  	}
d743a182d Davor Joja 2014-03-24  107  
d743a182d Davor Joja 2014-03-24  108  	encoder_sfuncs = encoder_slave->slave_funcs;
d743a182d Davor Joja 2014-03-24  109  	if (encoder_sfuncs->mode_set)
d743a182d Davor Joja 2014-03-24  110  		encoder_sfuncs->mode_set(base_encoder, mode, adjusted_mode);
d743a182d Davor Joja 2014-03-24  111  }
d743a182d Davor Joja 2014-03-24  112  
d743a182d Davor Joja 2014-03-24  113  static void xylon_drm_encoder_commit(struct drm_encoder *base_encoder)
d743a182d Davor Joja 2014-03-24  114  {
d743a182d Davor Joja 2014-03-24  115  	xylon_drm_encoder_dpms(base_encoder, DRM_MODE_DPMS_ON);
d743a182d Davor Joja 2014-03-24  116  }
d743a182d Davor Joja 2014-03-24  117  
d743a182d Davor Joja 2014-03-24  118  static void xylon_drm_encoder_prepare(struct drm_encoder *base_encoder)
d743a182d Davor Joja 2014-03-24  119  {
d743a182d Davor Joja 2014-03-24  120  	xylon_drm_encoder_dpms(base_encoder, DRM_MODE_DPMS_OFF);
d743a182d Davor Joja 2014-03-24  121  }
d743a182d Davor Joja 2014-03-24  122  
d743a182d Davor Joja 2014-03-24  123  static struct drm_crtc *
d743a182d Davor Joja 2014-03-24  124  xylon_drm_encoder_get_crtc(struct drm_encoder *base_encoder)
d743a182d Davor Joja 2014-03-24  125  {
d743a182d Davor Joja 2014-03-24  126  	return base_encoder->crtc;
d743a182d Davor Joja 2014-03-24  127  }
d743a182d Davor Joja 2014-03-24  128  
d743a182d Davor Joja 2014-03-24  129  static struct drm_encoder_helper_funcs xylon_drm_encoder_helper_funcs = {
d743a182d Davor Joja 2014-03-24  130  	.dpms = xylon_drm_encoder_dpms,
d743a182d Davor Joja 2014-03-24  131  	.mode_fixup = xylon_drm_encoder_mode_fixup,
d743a182d Davor Joja 2014-03-24  132  	.mode_set = xylon_drm_encoder_mode_set,
d743a182d Davor Joja 2014-03-24  133  	.prepare = xylon_drm_encoder_prepare,
d743a182d Davor Joja 2014-03-24  134  	.commit = xylon_drm_encoder_commit,
d743a182d Davor Joja 2014-03-24  135  	.get_crtc = xylon_drm_encoder_get_crtc,
d743a182d Davor Joja 2014-03-24  136  };
d743a182d Davor Joja 2014-03-24  137  
c0e6d299c Davor Joja 2014-12-10  138  static void xylon_drm_encoder_destroy(struct drm_encoder *base_encoder)
d743a182d Davor Joja 2014-03-24  139  {
d743a182d Davor Joja 2014-03-24  140  	struct xylon_drm_encoder *encoder;
d743a182d Davor Joja 2014-03-24  141  	struct drm_encoder_slave *encoder_slave;
d743a182d Davor Joja 2014-03-24  142  
d743a182d Davor Joja 2014-03-24  143  	encoder_slave = to_encoder_slave(base_encoder);
d743a182d Davor Joja 2014-03-24  144  	encoder = to_xylon_encoder(encoder_slave);
d743a182d Davor Joja 2014-03-24  145  
d743a182d Davor Joja 2014-03-24  146  	xylon_drm_encoder_dpms(base_encoder, DRM_MODE_DPMS_OFF);
d743a182d Davor Joja 2014-03-24  147  
d743a182d Davor Joja 2014-03-24  148  	drm_encoder_cleanup(base_encoder);
d743a182d Davor Joja 2014-03-24  149  	put_device(&encoder->client->dev);
d743a182d Davor Joja 2014-03-24  150  }
d743a182d Davor Joja 2014-03-24  151  
d743a182d Davor Joja 2014-03-24  152  static struct drm_encoder_funcs xylon_drm_encoder_funcs = {
d743a182d Davor Joja 2014-03-24  153  	.destroy = xylon_drm_encoder_destroy,
d743a182d Davor Joja 2014-03-24  154  };
d743a182d Davor Joja 2014-03-24  155  
d743a182d Davor Joja 2014-03-24  156  struct drm_encoder *xylon_drm_encoder_create(struct drm_device *dev)
d743a182d Davor Joja 2014-03-24  157  {
d743a182d Davor Joja 2014-03-24  158  	struct xylon_drm_encoder *encoder;
d743a182d Davor Joja 2014-03-24  159  	struct device_node *sub_node;
d743a182d Davor Joja 2014-03-24  160  	struct i2c_driver *i2c_driver;
d743a182d Davor Joja 2014-03-24  161  	struct drm_i2c_encoder_driver *drm_i2c_driver;
d743a182d Davor Joja 2014-03-24  162  	int ret;
d743a182d Davor Joja 2014-03-24  163  
d743a182d Davor Joja 2014-03-24  164  	encoder = devm_kzalloc(dev->dev, sizeof(*encoder), GFP_KERNEL);
d743a182d Davor Joja 2014-03-24  165  	if (!encoder)
d743a182d Davor Joja 2014-03-24  166  		return ERR_PTR(-ENOMEM);
d743a182d Davor Joja 2014-03-24  167  
d743a182d Davor Joja 2014-03-24  168  	encoder->dpms = DRM_MODE_DPMS_OFF;
d743a182d Davor Joja 2014-03-24  169  
3cd8d627b Davor Joja 2015-05-19  170  	encoder->slave.base.possible_crtcs = 1;
3cd8d627b Davor Joja 2015-05-19 @171  	ret = drm_encoder_init(dev, &encoder->slave.base,
3cd8d627b Davor Joja 2015-05-19  172  			       &xylon_drm_encoder_funcs,
3cd8d627b Davor Joja 2015-05-19  173  			       DRM_MODE_ENCODER_TMDS);
3cd8d627b Davor Joja 2015-05-19  174  	if (ret) {

:::::: The code at line 171 was first introduced by commit
:::::: 3cd8d627ba42366d755122d8d9d3384f476fffc6 gpu: drm: xylon: Fixed encoder client registration

:::::: TO: Davor Joja <davorjoja@logicbricks.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53771 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/57a1e924/attachment-0001.obj>
